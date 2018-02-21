Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224MOk/UlgdWOwroWRu4KdtCvN/6wmdlpJtIxi3KVHcoqL8nbyq2jD4/PhakoqsRtzk+C9Dc
ARC-Seal: i=1; a=rsa-sha256; t=1519218352; cv=none;
        d=google.com; s=arc-20160816;
        b=rsa7CVJU70KN80SGS32AF3JtZMW4UHehabpxN0N/0ggQ7zWrBV+l8q4hcOtZ/il2Ro
         8wkAf1rWdNxYC9eBTtoYA44Qsx9M63Z9SA81fsdEUe0duv59PLlWUtv+Dsbjt2AAjce5
         yDMMnjq4onj7kltQGrHMxRlb+BszEs+LSdE61BkDikCZyVSFzgBI/TCYihBKLvxDMVIj
         b1FcXvefejcjFp+IGqSU1unrO+y4kDX7+zMo+xA69yGyMlTeLAo6fTNG/DRQvvVuREfE
         jyjgL9/qxJCH6wzigAOIkX+KB+n2N7b9JK/dP4C/HGCeaI9L7woLROiZMbj+eiSbDR1n
         s/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DueSOTFI6t+9YioLzB8YWNwkAfDvkgKsql0VoeHDwgs=;
        b=iK84bDMUvJ6alScaysD3ANhXN7m6uEjNA1b/0CHLewnrFlL//K3Th+1SKEFXK3C23d
         QfBTp+DuV4KMy/JmTB1ZHfH+BRm7YJkDuyuJmYk6MlAAvtEwE2Ytaa2yhxjl/02Ahs60
         LSCnyGxREUG4GrP8wLW9ev+afp8SPGS2lR8uMJcD2aQeCqG40HuSn/MRXeANtcsxcKai
         z/67XlIV0X77kndP3AUurkmVF39hUryoSe3tkaH24QN9Q8n8ONrFEHgac5yj8NkElW41
         pdk8WbDyaFsaSo1aKUOV8UQn1o8uO5glEBqrZaV4zUIsrqAuyV+TnZJ0Wodys4b/wLU3
         00jw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Steffen Weber <steffen.weber@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 001/163] scsi: smartpqi: allow static build ("built-in")
Date: Wed, 21 Feb 2018 13:47:10 +0100
Message-Id: <20180221124530.021617261@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015175879199840?=
X-GMAIL-MSGID: =?utf-8?q?1593015903004073669?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Weber <steffen.weber@gmail.com>

commit dc2db1dc5fb9ab3a43b305c2720fee5278dbee2a upstream.

If CONFIG_SCSI_SMARTPQI=y then don't build this driver as a module.

Signed-off-by: Steffen Weber <steffen.weber@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/smartpqi/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/smartpqi/Makefile
+++ b/drivers/scsi/smartpqi/Makefile
@@ -1,3 +1,3 @@
 ccflags-y += -I.
-obj-m		+= smartpqi.o
+obj-$(CONFIG_SCSI_SMARTPQI) += smartpqi.o
 smartpqi-objs := smartpqi_init.o smartpqi_sis.o smartpqi_sas_transport.o
