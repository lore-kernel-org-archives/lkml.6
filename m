Return-Path: <greybus-dev-bounces@lists.linaro.org>
X-Google-Smtp-Source: AB8JxZqs9vY2SK9D22Xe7eUAuIm2xvGH11WbuXPzFPnOsF/5O9NcDWrXepGH36ijV6mmt1eK8+9s
ARC-Seal: i=1; a=rsa-sha256; t=1524198275; cv=none;
        d=google.com; s=arc-20160816;
        b=Zz3LMotplRCf2pgGy0e/3cM9WB1JWj4E4uF7w93uRnkSahw15JE+5mAiH9DPBc4Xz1
         a21RzELnfqUg2PpJ8WerxrfU9zPQfsd7H7iSkRLLsqq3+KZ047VNV/aXSyxYcZ7OSUOy
         FxWZqOo2SUTxHFdLN+u3JYQ6x5jn8PZWWjzbnT7Yomk4Ya3o+IbKTV20ssyAIAsC9IAV
         214xKwVgenl5tVQsHdgzlLm9FOeOwuS5PO5bhXqCyu4X62g+33xdIUpjHaduNUqHh4rE
         sEBIKeVN4PmK5eBZolputQKXv9Qsse5e+tNrE/O14xzDuOgmX1coUdcgx2KxuKaWQMeD
         ayJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:errors-to:content-transfer-encoding:list-subscribe:list-help
         :list-post:list-archive:list-unsubscribe:list-id:precedence:subject
         :cc:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:to:from:date:delivered-to
         :arc-authentication-results;
        bh=213U+dmwDnfMitVLtolMju1uvBfZiwvjB9Rb3yditXg=;
        b=sFUdkJuukFKvL1/ihdeRkwHB1Xgb9Y/IQ5TCXABppIR/Q2o1emmFVvU0T4W3IKvUOk
         P4/J0TaSBrwkE6+BsvjSNejipQOM7liBBl3PI244YbQAOdxd4I8Td4ZWHkkOyIIpcDE+
         PH84D1zetc+zM/TgpQJSzwu/aN4jmvDlZRXyNcAy5xQfOg/a2NfJ4LZaqE2fmqgnD3pd
         YU4AMvW/ELHoxBPz7LER8B8nb8/YzemFAd1pc4iXQHeJGFGk6F+CFc4w9hLItUwtvWhO
         h3yuTGQsKC2f200uPB0J4E3C90NE2BRvVksa7sNnAqEjAYXz00L10pfSvl3Av2kI17XE
         +Z9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of greybus-dev-bounces@lists.linaro.org designates 54.197.127.237 as permitted sender) smtp.mailfrom=greybus-dev-bounces@lists.linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of greybus-dev-bounces@lists.linaro.org designates 54.197.127.237 as permitted sender) smtp.mailfrom=greybus-dev-bounces@lists.linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Date: Fri, 20 Apr 2018 09:54:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Message-ID: <20180420042423.GI24576@vireshk-i7>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-48-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180419140641.27926-48-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: devel@driverdev.osuosl.org, Alex Elder <elder@kernel.org>,
 kernel-janitors@vger.kernel.org, Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
 linux-renesas-soc@vger.kernel.org, greybus-dev@lists.linaro.org
Subject: Re: [greybus-dev] [PATCH 47/61] staging: greybus: simplify getting
 .drvdata
X-BeenThere: greybus-dev@lists.linaro.org
X-Mailman-Version: 2.1.16
List-Unsubscribe: <https://lists.linaro.org/mailman/options/greybus-dev>,
 <mailto:greybus-dev-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/greybus-dev/>
List-Post: <mailto:greybus-dev@lists.linaro.org>
List-Help: <mailto:greybus-dev-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/greybus-dev>,
 <mailto:greybus-dev-request@lists.linaro.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: greybus-dev-bounces@lists.linaro.org
Sender: "greybus-dev" <greybus-dev-bounces@lists.linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598183785757708408?=
X-GMAIL-MSGID: =?utf-8?q?1598237730720534573?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gMTktMDQtMTgsIDE2OjA2LCBXb2xmcmFtIFNhbmcgd3JvdGU6Cj4gV2Ugc2hvdWxkIGdldCBk
cnZkYXRhIGZyb20gc3RydWN0IGRldmljZSBkaXJlY3RseS4gR29pbmcgdmlhCj4gcGxhdGZvcm1f
ZGV2aWNlIGlzIGFuIHVubmVlZGVkIHN0ZXAgYmFjayBhbmQgZm9ydGguCj4gCj4gU2lnbmVkLW9m
Zi1ieTogV29sZnJhbSBTYW5nIDx3c2ErcmVuZXNhc0BzYW5nLWVuZ2luZWVyaW5nLmNvbT4KPiAt
LS0KPiAKPiBCdWlsZCB0ZXN0ZWQgb25seS4gYnVpbGRib3QgaXMgaGFwcHkuIFBsZWFzZSBhcHBs
eSBpbmRpdmlkdWFsbHkuCj4gCj4gIGRyaXZlcnMvc3RhZ2luZy9ncmV5YnVzL2FyY2hlLXBsYXRm
b3JtLmMgfCAzICstLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRp
b25zKC0pCgpBY2tlZC1ieTogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4K
Ci0tIAp2aXJlc2gKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KZ3JleWJ1cy1kZXYgbWFpbGluZyBsaXN0CmdyZXlidXMtZGV2QGxpc3RzLmxpbmFyby5vcmcK
aHR0cHM6Ly9saXN0cy5saW5hcm8ub3JnL21haWxtYW4vbGlzdGluZm8vZ3JleWJ1cy1kZXYK
