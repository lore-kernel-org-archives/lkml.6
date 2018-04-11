Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49OGfpf9ebdzt0I6eoqcjweILbD3XwkH09nYjCWfDSF56mxb7OG+Zv5x78/HLr2gBw6Dfbb
ARC-Seal: i=1; a=rsa-sha256; t=1523473242; cv=none;
        d=google.com; s=arc-20160816;
        b=GlxHsdajBYVlRc2zW8OL+tPyHZXkouEJkGyNL1A4o3ieQjqdihEkHhhz0iBqL5mpx+
         9RN7c5Sf8DIXDuuY6/mdu1zO8ka8mCR+CMkUWhLXnl7LimB/2RB+Bh2pMwUkb+J5mpwV
         WKIrDX1SeSC6LjhAL6Gv2S8t10M+AT6PGEmYb16yNbmKQlcy33IH7YQtd2xnIpvSjpLe
         sxLXULZ+YV0UqRxSzSUEpfmMBz8ZKe5fADMR8rq+ebYotWAA8gojfTb/Wo9bu3PC95r1
         9Nt2g1qwOzg9ALpeQwrCJfzAEblUPnNLsNDn3pGDRG9uDJJo7Bz0qvrMRyNj9KSLQKgC
         eg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QkQ47S6ft/mWvzquTjhW4Hf/US4PAK3v28pxcCGIHXs=;
        b=t/dZqfYMnNivVl/vTabr1/PNQuUGiV5JXrjplpKpE6WDTh3c4WIlVf3kMkFvlCQDu9
         O3Gy5GBf1rhozsjZ6ovLV1hMvblVDivxcXFmPJlJGOJ2cjhymYdIIsWSVPrfQ0FnU3a0
         vJPiIGPQH4qdy8ZfDkbHMvGff10t/0xGAM7YMFaxyP6Vy01lmlj8GUx+VQpJOuEPegVP
         VVrW1TTrRe55PZ8D0kr5bnZ7yXvBQAtwiY6TfD7UqbtFrsyWhyVlS/lLctg1IUx4Zbal
         tVVXXs/CQsVY2FL14oj78i3cI/znHHaxLfHJmW+MdCP5t4qLKxaCzZI06i8vjOnEaQEA
         dX9A==
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
Subject: [PATCH 4.9 145/310] ASoC: Intel: sst: Fix the return value of sst_send_byte_stream_mrfld()
Date: Wed, 11 Apr 2018 20:34:44 +0200
Message-Id: <20180411183628.683371924@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476655454748171?=
X-GMAIL-MSGID: =?utf-8?q?1597477478473096104?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
