Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+otr+YNmlEYh1V6E0b7spdrGy6kQ7xpk6jPB/gcv7lsJPWfw16pBiw+2lnWghTMs/3sKFI
ARC-Seal: i=1; a=rsa-sha256; t=1523399316; cv=none;
        d=google.com; s=arc-20160816;
        b=mX24YzD0JL+w8jWQ5FZY8iPut6oMK0cXFeQ10J0nXR7CQ+F9Fb7dWRcmk4XR6EPNj2
         HXHPN4A5oJfMz1rjmeiSQnAspbxDYHUcMKq8k2xAPjXOL1tw9O8kFZTGL2lPzMFm68xE
         CvulHTEt6RH7Yi3oRg0wiZQCy0sBrqv/4AveiM2XK7sgDob4bpwb6yHLbPb9B7uelFrR
         ZgGfP1D+prCxyAogEbopwl+5H7SfC0k+ZV43bedTcjTJrwBl2qXLXuKvfRlmlo7LEnef
         orn0xVMof1CL2tWdMMtoAsPyRr8llkYgCDaxJ8CzYV2e3tqFwCsKgaD33jIbS1VVsPZs
         M4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2hGT2r7OhZckF8CgkdpQyujHX9wytnH+bmL5cqIuRv0=;
        b=wf1l551r2Kw2F+LR0QzTqLOzTs1xVpZZjpflApqVTPktfv/lkib9ui+1O6T143k6pP
         Db1a5GP2bWXtGcfSXopap0qlTCT4TX7HFQ7FiwkrvcXb/7Ejsg70UNifHEgigMnRPSLK
         WrWWsCRUoEFCvC2Z6B1C8+/9pUjYArUiFGj31rUbsVJVzKGDGPuoq4jhLn/Sm1nslh5D
         /Q2qrhCb8sOaiZ0VjK3pGZ/4DYJ0Xb10Mb71TXxQPgc2T7oeXrUhLGcgrLuTBXi76sEu
         6yURpNmtNPIbKUlsby9aiEN+SVlqNRt9Y9B7OEa7p60+E2BBGR/51Vyeyu+aQ2JqP6TY
         /x0w==
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
Subject: [PATCH 4.15 063/168] ASoC: Intel: sst: Fix the return value of sst_send_byte_stream_mrfld()
Date: Wed, 11 Apr 2018 00:23:25 +0200
Message-Id: <20180410212802.879658066@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399961609133580?=
X-GMAIL-MSGID: =?utf-8?q?1597399961609133580?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -220,7 +220,7 @@ int sst_send_byte_stream_mrfld(struct in
 		sst_free_block(sst_drv_ctx, block);
 out:
 	test_and_clear_bit(pvt_id, &sst_drv_ctx->pvt_id);
-	return 0;
+	return ret;
 }
 
 /*
