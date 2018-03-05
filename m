Return-Path: <elfring@users.sourceforge.net>
X-Google-Smtp-Source: AG47ELumIJNSdC5lVwMkssKkywKd+THwJczmA7W2yUPrHq5hCSQg3rlWWrIlC0sWwnudF1fQL/Dv
ARC-Seal: i=1; a=rsa-sha256; t=1520266852; cv=none;
        d=google.com; s=arc-20160816;
        b=N0ggN58w6QFJ1PkfmLO5Bq4GwKuaNxC8T1MyQ5iCR0OP6RG6Xt9OrdvMNQgJNWYOcV
         Czo1Ug/so1VCSFyQ2puresAz3/0LcFmsjdys9bVAO2QEgWgMOnDXVux0p8I0K0MSFl1P
         gPXqG6neRKcNBL8W19ful8leen12VkzVKGHug5CvFeWIMU4Qbdl2DGtq9dtNEXqvpZMH
         X55RfX2lDPVVCOQy4tJtJPMTJAOeb/UMiY2wsu/+QWtQ/x6kcURrXjJisvN/uClyjiC0
         GSn7r6bG0bG+tHcOVl2LWvI8RbXCJ5Hk2i5M6h8JEIdekokss3kp8bCyMlfGBiD/ckaf
         8ylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :arc-authentication-results;
        bh=4OYjRmsr7Mt9SduEw95siK1PcWemtPkor4OSzjYlAmo=;
        b=cb0iQq+6lOa0UfoAT0jOwG5FjJDJfL5005euXqNK3p26reEtb+gE2mCRIIaYFk5Idy
         0vzvjLFuOELj8Fecs2nvrStWpapuNLqCjfQz8+/dkQO575qQxbq2pXrgLVK5xQBm5Thv
         ITqgUHPANzMgbLARzCUG2FM+e+9FnIsfZiW4C+M01CWCzrUTl34tS0xtIvkgoVdXmlN7
         u8J7vvY/hAAjyH/GWQc2DtZUallwZtxK/gjvuX8r5Qk3t31Bl1Jz/aUNro8M0uMeXxBC
         bYHGCGj7XIhPUyMLG5Iz+vQQFmbbBkQu7yZXysGHM3q081G+MeeQnPlxx2XLTEHsI2wB
         EFvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of elfring@users.sourceforge.net designates 212.227.17.12 as permitted sender) smtp.mailfrom=elfring@users.sourceforge.net;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=sourceforge.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of elfring@users.sourceforge.net designates 212.227.17.12 as permitted sender) smtp.mailfrom=elfring@users.sourceforge.net;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=sourceforge.net
Subject: [PATCH 1/2] VMCI: Use memdup_user() rather than duplicating its
 implementation
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: kernel-janitors@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 George Zhang <georgezhang@vmware.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy King <acking@vmware.com>,
 Dmitry Torokhov <dtor@vmware.com>
References: <66411a1a-fd12-dc31-fc2e-800ff6cea1ed@users.sourceforge.net>
Message-ID: <7c97d2aa-7d3e-468f-cdb7-795a50d437c3@users.sourceforge.net>
Date: Mon, 5 Mar 2018 17:20:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <66411a1a-fd12-dc31-fc2e-800ff6cea1ed@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:vy/sL+e5n2BdprGyMMTAp+F1/1y5tLRXUYck/cyDrP43DH8LJNf
 sQfEVe9kzpcgLr7onn8DEsuCvNvuS/hPSvcNVGqL0LQ+KKrzrcTKMOTOa/Bt1Z2wJNvM89O
 RzywKSLE465HaH1TofKfb/ttg8Z+ZgId1vdQfvtwbxySlO68QIhKXgTqkytVBZaBwPo1ASb
 0G5pQXtQ9LSxctTVOhNBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pCPJo9/5U6w=:ZgmDoyrBejftz+wrnJywhH
 KpeVAtaFgmRMOrsrRl+PRd1osIrYxJNod1bVyQ1yMHsHmMR0MpVEyMGBpQB+pH820thVwmvzD
 GB9/oljbXse0mx+chTKfQLkE8sNdEgJVSw/yZs3aCsnEQB2P7N5scvWJEHBWUfyujHih8ROOx
 aVXUxcoZk9HlK3AqwWbw1wiA5RVFUMi5BbgSOu4c8BcyFfxNBJvTopraOUH8b3xmAn9YTAimC
 fl9Ubqwaj0hkMKNB3NGzvX7Uo4ZtN5r1LiYz4OuL1AhfXYIAi8gPbo0xxFEK8/WAp5IrOge2P
 Ehxj6MsMDJ4Lnu3H4GwyPTGJi5jPzmACl85RMzLbelqhTGu0kB3qcY4UI48QMoOW7ps+3BTk1
 yMXQyiY9qX09mA+beWdmwXdS4wymXjt3WQq/Ii15VPci2WcCPZIm0cHJ/DHVCugzNgHwDFgAk
 X3FhAkYZWMjdcecmwdKyRQTqW6IMSVM6cli12M/5KkVyJuSS1xOrpBt398CU8wLsMCWEntUcv
 P46mr50kxFtr54oioWt9pLsYd/fG/bh6lstb4vClci40dejobSg4sByt88FW+GVuD+asAehG/
 oiZL8HcNI2jjHvZ2BR37SpdxYtIxx09iKf1eoeE6nzfM0Ex35+u9WXhibrv96N7duwIQuRPAx
 XakQQhMDG+43dy+jpmqSxFcIrn9K5Tf+SDHSM9dLrxXsNVZqLAqDmCrNlv8ww/B53gdXu8V6g
 /mzkKz7lyxiBK5iDhJPdr7pEL59x/kW6f/dfqUmerJxhECFOqk5lBfvNs7vO0SailhyDq2h5v
 ToQ32xd0vSkdKaCNtHW2ZTrxqIhNHnFYmRKUGEdJfjvJSk7NnM=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594115334476141638?=
X-GMAIL-MSGID: =?utf-8?q?1594115334476141638?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Mar 2018 16:40:29 +0100

* Reuse existing functionality from memdup_user() instead of keeping
  duplicate source code.

  This issue was detected by using the Coccinelle software.

* Return directly after this function call failed at the beginning.

* Delete the label "out" which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/misc/vmw_vmci/vmci_host.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index 83e0c95d20a4..fb3d92a21afa 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -754,27 +754,16 @@ static int vmci_host_do_ctx_set_cpt_state(struct vmci_host_dev *vmci_host_dev,
 	if (copy_from_user(&set_info, uptr, sizeof(set_info)))
 		return -EFAULT;
 
-	cpt_buf = kmalloc(set_info.buf_size, GFP_KERNEL);
-	if (!cpt_buf) {
-		vmci_ioctl_err(
-			"cannot allocate memory to set cpt state (type=%d)\n",
-			set_info.cpt_type);
-		return -ENOMEM;
-	}
-
-	if (copy_from_user(cpt_buf, (void __user *)(uintptr_t)set_info.cpt_buf,
-			   set_info.buf_size)) {
-		retval = -EFAULT;
-		goto out;
-	}
+	cpt_buf = memdup_user((void __user *)(uintptr_t)set_info.cpt_buf,
+			      set_info.buf_size);
+	if (IS_ERR(cpt_buf))
+		return PTR_ERR(cpt_buf);
 
 	cid = vmci_ctx_get_id(vmci_host_dev->context);
 	set_info.result = vmci_ctx_set_chkpt_state(cid, set_info.cpt_type,
 						   set_info.buf_size, cpt_buf);
 
 	retval = copy_to_user(uptr, &set_info, sizeof(set_info)) ? -EFAULT : 0;
-
-out:
 	kfree(cpt_buf);
 	return retval;
 }
-- 
2.16.2
