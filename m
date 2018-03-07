Return-Path: <gi-oh.kim@profitbricks.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520415270; cv=none;
        d=google.com; s=arc-20160816;
        b=cpzVS/s7xKoWyWMkDnScNv97Se1CKFkWuwWV5fy1/hU1VJNbFoJ/wJR/Pp++RBhaJa
         QfHZRHJLQqV+VeimWo52c9z6vESJaxkaI7pmdmjne8SICi5cbOIm5DJlj2eIMl6Jae5h
         BcMnGVaPVHMG8frdlZQr0xzu3yDhMs2mkfSHFMHAaWgEUtuzZzF1S9y9Xo2alGTB/kq3
         j//Bwt/Cq7wvBXixkmCpAnyN++GYswl3n62CPjz6Wi3piUcL68O2jvPHl62f6TRAnQ2Y
         mstj+RE68sMSM3RX1PZ/Qj5unhi4H934Gvb6RHPyYWnmt73dhH13iu4h/nMsUeTY7c88
         LZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=xKJ/F4L8DFWz7HmrCqv0ZxIIYTLAPi3QNd+kfMWkCQ0=;
        b=KKN1inWo/01Gw3oAyuOxP0OI54tGYyeG3EQGjIt3W2VAbUNVFBeVYE1xuEmMOH54Aj
         TXQ9mc38fEJKpccEyBxUWwXpyghZE4ucqISCpa40US7pGS+rgbeMqSD1f9p69pO36N6X
         247OjE/kY9XDtn2uV7WiGDX1EDrHhaRiEr6gwdY1DfTxMM48DaSjU4iTgu4vlarm0fvM
         vAmrC2NY2Z0VPdu2/mt4RZW3qIhIRkQXdjPMFvtPT/pVnUaeGOJYBfLfsChIofE1SeTd
         WqEuVmZDjBHQlvQMul3Cwnp4yiTvK9We5FxhGXNFvx+PM6M6dCOpuMyoIsYeLoBhyNlI
         +OFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@profitbricks-com.20150623.gappssmtp.com header.s=20150623 header.b=qf100x4b;
       spf=pass (google.com: domain of gi-oh.kim@profitbricks.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=gi-oh.kim@profitbricks.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@profitbricks-com.20150623.gappssmtp.com header.s=20150623 header.b=qf100x4b;
       spf=pass (google.com: domain of gi-oh.kim@profitbricks.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=gi-oh.kim@profitbricks.com
X-Google-Smtp-Source: AG47ELs2+QdYlZqmdtQ/GAYquIIQAB1s/vZ6C00cIWRwTOhQVkUreV55J47O2IqBFbhCf1Tsbp+2Ow==
From: Gioh Kim <gi-oh.kim@profitbricks.com>
To: linux-kernel@vger.kernel.org,
	kstewart@linuxfoundation.org,
	tglx@linutronix.de,
	pombredanne@nexb.com,
	gregkh@linuxfoundation.org
Cc: Gioh Kim <gi-oh.kim@profitbricks.com>
Subject: [PATCH] setlocalversion: use any tag
Date: Wed,  7 Mar 2018 10:34:03 +0100
Message-Id: <20180307093403.19610-1-gi-oh.kim@profitbricks.com>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594270962675824355?=
X-GMAIL-MSGID: =?utf-8?q?1594270962675824355?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I googled about '+' mark in kernel version number. Many people also
do not understand why their kernel version includes '+'. And many
people creates an empty .scmversion file to remove it. I also
create the empty .scmversion file whenever I clean the kernel tree.
If setlocalversion script uses both of annotated tag and
lightweight tag, it would be more convenient because it is common to set
lightweight tag during developmene process.

Signed-off-by: Gioh Kim <gi-oh.kim@profitbricks.com>
---
 scripts/setlocalversion | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 71f39410691b..9f4309697ea6 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -49,7 +49,7 @@ scm_version()
 
 		# If we are at a tagged commit (like "v2.6.30-rc6"), we ignore
 		# it, because this version is defined in the top level Makefile.
-		if [ -z "`git describe --exact-match 2>/dev/null`" ]; then
+		if [ -z "`git describe --exact-match --tags 2>/dev/null`" ]; then
 
 			# If only the short version is requested, don't bother
 			# running further git commands
-- 
2.14.1
