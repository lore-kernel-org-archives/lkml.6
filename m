Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2278XozZgHR2DFusq0bg5A8r9+EJawnEbp2bk6jeMWq9QnmLBRb1u1u7vKrRxMgMlyrZ47Kz
ARC-Seal: i=1; a=rsa-sha256; t=1518708961; cv=none;
        d=google.com; s=arc-20160816;
        b=efdK9y2KLQCqSXHxDm88zvWezw6lhex1zsZv91dj+KQkHKfvG6rnfn+K4GnUZotN7g
         lkopnm5A95yCeBU47VF6TovYJmQRGt2TnSKrLMUVLHkyNRK+yDUL6M3jWfNAREfBkDsv
         Lxh5SFjwNHrGytPgfCULVPW6Nre5tfCCDB/xmd6u6UwZOpChywU7d86jMK9dlOTO+P6w
         YgXe5L3jSB1IU9rFtPXYT6uCMEc4iBjlbqYp64WSPENq97h89hNlOiiCC/YQ81ipOpuz
         63aGzzhTGFitxNiXrHBuxCT86mes490NCnRNLxk/8vzl5kvwmjIKe9fGK+trRc2+QcT3
         wyMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wEUROyW0xcs2ke/Rfa4LhcKTvsQmJ0GlTP5HKcxlUAc=;
        b=fD+rdLTm3/X+SlYMffIeX5C2H+Jg9VIn8ExYXASt9xOhwrYJDSdPHWSVoyn2IapsGP
         TT/6HDxH+qLYyUqTSTu0lm5dX/WndOEDr0bqhGniXhjuP5+o9WDY39Sw5HWZDK5n504q
         L3H9JkbFxyReU/w+niYzrulBvzzlcgxTTCwnNGIYUVI10+ur1BZ7MZUrAWc3SrdHvak2
         7RIVkB2m5GhLo5OPph9Sm7PgPSFWudRrE813EnixQ4yneMIeDWdVfH92RgGSXb+MlMi9
         KWGuhOmK9I8NeMmNir/F0S9U3CJPfCGUu/Bjdvp4Mv+uOEOQryyH97OpUwz0LuMu+C2L
         Nh3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ulf Magnusson <ulfalizer@gmail.com>,
	Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 4.14 142/195] KVM: PPC: Book3S PR: Fix broken select due to misspelling
Date: Thu, 15 Feb 2018 16:17:13 +0100
Message-Id: <20180215151712.893209045@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481768610584861?=
X-GMAIL-MSGID: =?utf-8?q?1592481768610584861?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ulf Magnusson <ulfalizer@gmail.com>

commit 57ea5f161a7de5b1913c212d04f57a175b159fdf upstream.

Commit 76d837a4c0f9 ("KVM: PPC: Book3S PR: Don't include SPAPR TCE code
on non-pseries platforms") added a reference to the globally undefined
symbol PPC_SERIES. Looking at the rest of the commit, PPC_PSERIES was
probably intended.

Change PPC_SERIES to PPC_PSERIES.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.

Fixes: 76d837a4c0f9 ("KVM: PPC: Book3S PR: Don't include SPAPR TCE code on non-pseries platforms")
Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kvm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -68,7 +68,7 @@ config KVM_BOOK3S_64
 	select KVM_BOOK3S_64_HANDLER
 	select KVM
 	select KVM_BOOK3S_PR_POSSIBLE if !KVM_BOOK3S_HV_POSSIBLE
-	select SPAPR_TCE_IOMMU if IOMMU_SUPPORT && (PPC_SERIES || PPC_POWERNV)
+	select SPAPR_TCE_IOMMU if IOMMU_SUPPORT && (PPC_PSERIES || PPC_POWERNV)
 	---help---
 	  Support running unmodified book3s_64 and book3s_32 guest kernels
 	  in virtual machines on book3s_64 host processors.
