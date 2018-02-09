Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2278dsoeAOpdIu72YCctJihCRTW4QuYEcoegw1ssGGfdUMxInXwuWlgdy7jEnVj05YKQeaCh
ARC-Seal: i=1; a=rsa-sha256; t=1518183999; cv=none;
        d=google.com; s=arc-20160816;
        b=Y1BnYsmFZgma5x6RP8pJSTPzzbaGD7xOdADlem6mEoQ/sYgVMXWOoWyYg/7BhPbhpp
         rlmjiq/zD8+W3IOTN1n3R8WMfZetCFY6lwupUN1qAJKpu97zABpisYPXiXabzt8g8ppG
         hCb19W5VigbCsIQG9Ji/7aTxS6hgesA5LawKuKFMy/K1gHVwxm8wTlPZStRW31XNRTrD
         Fc/w3Ln6/nx4KGo1HLex0WE/pk4qNj7snycc+07HLUW+GCiHoDxsd4F+9irmHI/AYCi5
         xpMtvWJ0QoN4DOje5K7muCKsjw1P1bIGSXoLpk8Js9sEmNrEueUPIitdTf6eU/YHz+JW
         O6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7TfjOVqVnh21Sl4EbC/CQ5r0W1gy2uO1MA/wto66WO8=;
        b=euqBgKp0Y2u8ebBssri6EBs7macMryWtG5njC/AqymVMSJJK6bMoiPciNU7ixf/+2w
         15fci0M1cne3dyt2wc6jmZu+B0FM8/tkD1XlHVhLWCrHVUeMn32ZGkDPaVvA7zbJKCjL
         7sE9Ea7KEUa4trJEP+yX9mqKW2EKoVjCruMUA1dE2eFzfks/EBVFfdXjsMBK6QidtOmG
         EMN9/oh5YFCQsf2nMJBv5HOBF1dIdTxMhI1Ks7EXEiMHWsNZPqFX55GwUKd2xkAQPAtB
         JhYLHlCNILn1jQbFqSm4pNR/6eHeRaM8OsIbUqaZmjZC3EbuSmvMIhjrA/fXwqmPQJDU
         HwyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jesse Chan <jc@linux.com>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.15 19/23] media: mtk-vcodec: add missing MODULE_LICENSE/DESCRIPTION
Date: Fri,  9 Feb 2018 14:40:17 +0100
Message-Id: <20180209133939.265353184@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
References: <20180209133938.366024920@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591931224626013757?=
X-GMAIL-MSGID: =?utf-8?q?1591931305838004291?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Chan <jc@linux.com>

commit ccbc1e3876d5476fc23429690a683294ef0f755b upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/mtk-vcodec/mtk-vcodec-common.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION is also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
@@ -115,3 +115,6 @@ struct mtk_vcodec_ctx *mtk_vcodec_get_cu
 	return ctx;
 }
 EXPORT_SYMBOL(mtk_vcodec_get_curr_ctx);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Mediatek video codec driver");
