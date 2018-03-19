Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtwgUfLnqMtfpyQiZsd1kpluUtwWORHDVnvr5Yl8awHOksxp2FmEYjflu50QHSH1jX5fNSC
ARC-Seal: i=1; a=rsa-sha256; t=1521483840; cv=none;
        d=google.com; s=arc-20160816;
        b=z7kXNAoTpHLxTD+qcefgLA5ymNOdF6pJXtCvMY1EnxFJFtlMZX/HVeOubp4zbvw+5n
         Bf20M4j3u56pjHRHtkjbzH7wTzVxgmHaTBVlyf2CPEhEBJhTST/RpYyGLT93Ap8MvcDN
         yj1qeOI4sB0hVJAXWVZolvUeHQ1gNTE7SY1lnBYMS8/+8tkDRb3LUJ6IddZBeZTV04M2
         HXc+3UCAKQKqHdLoHMts+rt8qbss47yVrye9Hxa67nTk+ZHMZvjg8ko03GYy6El77Wzq
         zP8weuiLVI7A29EFtmvIHqVsZq69bgHNzp/bStoRqGhUU/osnYwxpLl0BjF1FayF3uOe
         I+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qaC+pz75EDTvTMIS+c6LuMJFHwNsCOSeGbie0wHCT80=;
        b=cgd1X960Bk/bTbfPq3cGoGzR8AEVpcRScnxzfq61Lrm+fHhyqQFWvEhrw2R+v2uY7J
         o++qgzLV8GZWFxAr+ZPjOowGXeJbqnYDVqs0CT9m4gKucA2ruik0vZG1CGh3wso5sVwE
         QFyjHj0ZTM8oe/4+7kjXwJS09pNnM4/HlUt6FGYOtummQDII6Swh06Llftd1uJTnPV8I
         wbKaw02SKroc/VI6L83+M3rzcQQhNTAKkrAv7MckL2aoHN7WCv7mFd0KT7GlgJV32bSQ
         ErXh5BBfeljLIYlrCI3SsaNtUrNYmXfAfDs5wlSo/SNlXUnsBIrTUSYcqW6g+JrlGqMQ
         mRQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 135/241] regulator: isl9305: fix array size
Date: Mon, 19 Mar 2018 19:06:40 +0100
Message-Id: <20180319180756.782897020@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390687763949182?=
X-GMAIL-MSGID: =?utf-8?q?1595391440059524338?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Vincent Stehlé" <vincent.stehle@laposte.net>


[ Upstream commit 0c08aaf873174c95e674cf21ffcd041c589d2e5b ]

ISL9305_MAX_REGULATOR is the last index used to access the init_data[]
array, so we need to add one to this last index to obtain the necessary
array size.

This fixes the following smatch error:

  drivers/regulator/isl9305.c:160 isl9305_i2c_probe() error: buffer overflow 'pdata->init_data' 3 <= 3

Fixes: dec38b5ce6a9edb4 ("regulator: isl9305: Add Intersil ISL9305/H driver")
Signed-off-by: Vincent StehlÃ© <vincent.stehle@laposte.net>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/platform_data/isl9305.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/platform_data/isl9305.h
+++ b/include/linux/platform_data/isl9305.h
@@ -24,7 +24,7 @@
 struct regulator_init_data;
 
 struct isl9305_pdata {
-	struct regulator_init_data *init_data[ISL9305_MAX_REGULATOR];
+	struct regulator_init_data *init_data[ISL9305_MAX_REGULATOR + 1];
 };
 
 #endif
