Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48vKke5NcWFZRLREnc3CEFbW5FNpUKY0YV8Kn/+Kxzdirjsx8oylDNpB2kLZtzRcmHw8iLq
ARC-Seal: i=1; a=rsa-sha256; t=1523473041; cv=none;
        d=google.com; s=arc-20160816;
        b=cd/NyT4EuNPKCTtrDqWvua0jfGzx+8i6W/zbGBj2KNEy9dagc+wFU+PKYwyv6MMjYm
         Jgs4CUnnTllMK+fXet0PeEblvhRtz6uB47ScxFyasxKPKUu//7jLb5cop+0tSLj0eCb1
         IzKynWDfdhOXffG5p0K+2Xnv8p3gpggfCEE6FwPs+Fhk37RWsc86ueI98TZ9BA6hx4T+
         +ky4n/OaQEjNnUvnVgJ/nlWr6RkCyq4gbndZEoiVYRkPxdhjg30W/gAqHX9QjPxil4WF
         StDHgD45ls/iBnl9Gcd/lEzUkfkO+E/8DTtsNmJrKjKGUm+2t7W50gc5voGxvlz1WzEL
         cKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aljzDasVIYyFm0P51pgAkPUJ7RISI5W0Cj18ksawVVk=;
        b=UUUNthTBX4+FFXZkl+fKcpps396t/OhLaKnNdLUAaQUtK0G0roisQdljfytua8KCuh
         Ex+JhF7aIao/Xtdrjkufs8MkudKh77bzXd+aiVaUAuPWUO5q+4zV2rXsUJtGmgsaFYkf
         jGdV2SftSbArkhMnm6cX0IME0p2blkiWfpfUvZpgtVubC+JS+upfm81n88nFvxk8Tyr4
         00IB0u2Yzx0oXbGKOEKU3NPgPqyR+s3RGRwqK8dDULORN14Ne2SIyV2VyzfGbvslPaIq
         lNY2C+01qY0vZac5vimf8AiaHsGQv1sceZsLkr2koHNej/ODrCi2D30oXZxyASZJ687k
         K8Fw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 064/310] ARM: dts: rockchip: fix rk322x i2s1 pinctrl error
Date: Wed, 11 Apr 2018 20:33:23 +0200
Message-Id: <20180411183624.988684282@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477267931564184?=
X-GMAIL-MSGID: =?utf-8?q?1597477267931564184?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sugar Zhang <sugar.zhang@rock-chips.com>


[ Upstream commit 9d420e9b4140f8938ad6aa0d29e2428a2af6122b ]

Refer to Chapter 5.3.2 of rk3229 TRM, we can see that GPIO1A[2,4,5]
using RK_FUNC_2 not RK_FUNC_1. This patch fixes it.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/rk322x.dtsi |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -617,9 +617,9 @@
 						<0 12 RK_FUNC_1 &pcfg_pull_none>,
 						<0 13 RK_FUNC_1 &pcfg_pull_none>,
 						<0 14 RK_FUNC_1 &pcfg_pull_none>,
-						<1 2 RK_FUNC_1 &pcfg_pull_none>,
-						<1 4 RK_FUNC_1 &pcfg_pull_none>,
-						<1 5 RK_FUNC_1 &pcfg_pull_none>;
+						<1 2 RK_FUNC_2 &pcfg_pull_none>,
+						<1 4 RK_FUNC_2 &pcfg_pull_none>,
+						<1 5 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
