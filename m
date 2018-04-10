Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49cV4B2eePcuMuLHTHKOFDovKiYGXEkRnGHP/fdPPstapoz/Xc39Rif8V0gDkpFISzj1nLv
ARC-Seal: i=1; a=rsa-sha256; t=1523399793; cv=none;
        d=google.com; s=arc-20160816;
        b=I6EV8FawNjIX8xDLbnOj1xuRx2wpQpcFXh1sjO1RzuDT02GE3K5lHadnB2bGi+NCKZ
         M0ZPsZYmngcjF+kUYjoZtOt813qKa5E6X1f/3GJ1y2w+02VjzrvGDrio9+D9h1W/zPtL
         bHLLgNhrKfWqLgit1UPm6j2zBTSZLsr5ypt4JEFB8D8rFMZu7+BTzAmq5xZrQ4kd/ZqH
         GaKb3Lum2WYI3YowD6ilGOQMpwbqjj/kvy9v/qh//yIfuD5/cDRi3k0vhe6W0gx6qIut
         GS5S2rNaRNUqyYhjTqjs7wAW5Y0SOQlcBvVjds3pSBnJ3pvWUADAZi8mzyh5J02jvDce
         dPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=i/AvWV2jDA6UxViYdmX/wj185ZrRn3hSbDhnZ1BdI6U=;
        b=XlMIEwSi4TxappNYI2Q+erdoB+0X0UPRqZJOthY+2NbRVMMebnTLtvvnUGNRZ9l+j9
         c0dbV82S+laYt+IBXKg/44cMkaZi6S5fqcwv0I88DsoH1gv03+wtxaY4tlKwya5fUW+o
         aO+Q6h68KQnr47uJZuqIG5RutvVjt6wgCwWwbxTITh7yUu6EZf/Vn9pPOyzJ1O6TnvOM
         wNsZSU6eALWrrKoS2cuE5TD0GUyE8kpFegJGuk20Gksd26VvoIY6gH5U9C3TbSPI+wQC
         9TBUHzeKIozqj2Gb1eQ+iKph45dUWc2SW8I/zC4gmRssnAY5nOAVfV25bQFL8C6O1vu0
         oKnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 048/138] ASoC: Intel: sst: Fix the return value of sst_send_byte_stream_mrfld()
Date: Wed, 11 Apr 2018 00:23:58 +0200
Message-Id: <20180410212907.679789760@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399961609133580?=
X-GMAIL-MSGID: =?utf-8?q?1597400462037141950?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit eaadb1caa966a91128297b754e90b7c92b350a00 ]

In some error handling paths, an error code is assiegned to 'ret'.
However, the function always return 0.

Fix it and return the error code if such an error paths is taken.

Fixes: 3d9ff34622ba ("ASoC: Intel: sst: add stream operations")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/atom/sst/sst_stream.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/intel/atom/sst/sst_stream.c
+++ b/sound/soc/intel/atom/sst/sst_stream.c
@@ -221,7 +221,7 @@ int sst_send_byte_stream_mrfld(struct in
 		sst_free_block(sst_drv_ctx, block);
 out:
 	test_and_clear_bit(pvt_id, &sst_drv_ctx->pvt_id);
-	return 0;
+	return ret;
 }
 
 /*
