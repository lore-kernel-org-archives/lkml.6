Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtlAC4tqNDdnBLYzQng1bWwQkLJq1mPyqvvcHwrk7r3X/2o++doZ/KgjaTlYl9leyP33h0M
ARC-Seal: i=1; a=rsa-sha256; t=1519411591; cv=none;
        d=google.com; s=arc-20160816;
        b=KUnp7mA1FxgZVfTIDm6wZbBmX5rMEIiH6ieK9lShb2EOfpU3TMkVsoICW4EmzE34bM
         5MwttSr3yI5XaFIRfQ9KQnHj6W7hH5nkYllwOW8hXpo+2zTeXg1jz5I62+8I+3QtIDaG
         EXG6+QBq9xgYtsBynTxBmFy7iVxt5EeLgXI/by475kAapnOHuXDd3a4WwpJcxq9lB0WU
         vpKLA/sdVktTkvZBz04cvAdpnjQ6Gtg0iscsrSeVxDjzccMLDRfZJZQytoe7U6++T00+
         q3id/2pmwf7tpZkhij9pFDjzdUzeSy0qvOmpFte2mJvoCl0Pk7W8GaCzP+FS8QIMBEbY
         cvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jnKn9S139ZiWjAkTJsDxiXSFZ1Hycv2c4WW8Sp0FGQ4=;
        b=he0sW9HJOWp6/MD8ODMI7mMK15pjYpQ9rUEdBpT7BSIw3gOYAijWz/+EaBXrJMbWcK
         k720cwrMxYGqojDVTORA0/8Rh85o7Tn1aAIErp7BiGwC+AJt7lVSb5P4mqau2pJhw6Wo
         37sxwe8AByKawjaQ1fq+ArKeJP1Q4yemR8TfAd1uXCruD2eenYHjggLXsf9YX8kijrCS
         c+2Afaog7AGWce9iQhe7Xv5M502TtnNc77ZQmG3hOB4Y+SOA1VaUg386hVcU9BAjOVA5
         FFambscJQar2ECKp1XYXrjAWbpEFKRS/1euSnqHRAz+Q4fkEfxuu0NX8mQgjJpu4ZhtY
         EpyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4.9 096/145] PCI: vmd: Fix suspend handlers defined-but-not-used warning
Date: Fri, 23 Feb 2018 19:26:42 +0100
Message-Id: <20180223170737.233041314@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218528982829259?=
X-GMAIL-MSGID: =?utf-8?q?1593218528982829259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit 42db500a551f97551a901e2258f84a60baf4edfc upstream.

Fix the following warnings:

  drivers/pci/host/vmd.c:731:12: warning: ‘vmd_suspend’ defined but not used [-Wunused-function]
   static int vmd_suspend(struct device *dev)
              ^
  drivers/pci/host/vmd.c:739:12: warning: ‘vmd_resume’ defined but not used [-Wunused-function]
   static int vmd_resume(struct device *dev)
              ^

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/host/vmd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -727,7 +727,7 @@ static void vmd_remove(struct pci_dev *d
 	irq_domain_remove(vmd->irq_domain);
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int vmd_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
