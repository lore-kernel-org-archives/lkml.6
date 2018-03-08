Return-Path: <stefan.wahren@i2se.com>
X-Google-Smtp-Source: AG47ELshFnh4QiQV1kpn4HnV+35KwPkMkgAY91kcOWi0bNLIjaQBtM5fueM+yD+I/gWkGzcppEM7
ARC-Seal: i=1; a=rsa-sha256; t=1520537422; cv=none;
        d=google.com; s=arc-20160816;
        b=b1airEvHeJAzwfu8t2F2H3h/dpoDpZhRvHJ0tjVH7u9mga7dL8EP8m4uW80srcjLfE
         1eSZBsmgRDCv2xt3IsNXsUzm2OnMa3mJyIXwjzmTxcxWZpL6fpQgS/Y2J0pDI+a8/mMi
         M8ZCORy3lxj9wN9/8+SqpCbDX5K1LmPAu+spo5fj3Bj3UyGruNFVr8qg7BgXWZAqArU+
         jDNV/oUtrU6IOf+ZBmP0E/i9tITsZTcCAdW1wluJWyYgA7M3Gz2h0vRdAy++xDbkYLZM
         Y0Fw3SagCynYjvfWXFfQFq2pkPx+pEWgCTqEFA2brOnyrxwaL/CZJN98ObsrZ6U8RdhW
         azoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=importance:content-transfer-encoding:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date
         :arc-authentication-results;
        bh=5Q4NO8D8jXrpQF7IZl1ra8cWAePUOYT762deyhyfQbg=;
        b=lyQ9SQVEZ4XiuIyZJA9nSFlp1SFCaPYUPimmWmtY5D8qHUFfT/aUfGYR32lDnVFMw2
         5Y4QKVibmcc69MUZMczLvEhRVh1foMNdy8EmD7hv46R/gFOw7v9u96fXEZ+ddY2C6t/B
         Jf9a2s/n8paFJdrS64HTEotbr5TC4xgnict36zDECFRYHJX1D1kxLoXkzfLJkT8R3Dec
         ajISFZ4erivpQI16NOAkvyY0/PNdVEsM4oTR/7q9W4IBdlzX6BzimJmOMY6c53OG2478
         ppfNLc35CVTxlkCMdtwAIJBRt6g/gAThGdw8MSfIYfXrofWrLTMpFTmIAvHDkHT3lwvL
         oQvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.17.24 is neither permitted nor denied by best guess record for domain of stefan.wahren@i2se.com) smtp.mailfrom=stefan.wahren@i2se.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.17.24 is neither permitted nor denied by best guess record for domain of stefan.wahren@i2se.com) smtp.mailfrom=stefan.wahren@i2se.com
Date: Thu, 8 Mar 2018 20:30:17 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Eric Anholt <eric@anholt.net>, Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Phil Elwell <phil@raspberrypi.org>, devicetree@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Message-ID: <1088519723.430987.1520537417525@email.1und1.de>
In-Reply-To: <20180307185716.17449-1-eric@anholt.net>
References: <20180307185716.17449-1-eric@anholt.net>
Subject: Re: [PATCH v2 1/6] staging: vc04_services: Replace "firmware" node
 with a compatible lookup.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev22
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K0:hczMKCHky6dKerhfECSarVJha5qv7P3eGw6wbG17n9iSUxi4bYB
 AZirBgQRn2nnEPBVSlKkLuOV2SwuF4kVH2UFJJ++hEbIQTeqIV0RxM+mm23sxdNJHs68YYu
 LDgd3shUeLxIvABXqK2CtozUY6bXZOk7vKbc6gxpXBaVrYi98EuAS8GlE7SKMSMvzUQ8M3Z
 A8SFzJKOl4feTsS63atFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cDZrUcv6w+Y=:RzAomfS9Sbb/zQ9WUemyp9
 IWQ4eG2rHSwWzA7Qkqo4CoxDnN34b4Txys4gSCb/EDXpR+rSHa/e328Z9XAIgVeLqkaIYxicV
 abjGxgLLX9GLkwL4DGYBb5+oV0iDIgn/S73x5JnxZX4segNfIAN/XF35jbrdLW4aw89WZv2Y+
 RnzbXWGh/MctTh0WtrcvjRFab8jVXvIwQH2/qnlYpOB7ONy1jYD4005qUhd+reeR4bMzBbw/w
 LuvpxDzCCsKLEpQSz+SLbQeM4ndOK0EKMzkQnbkkjhWYV8CjP5pBxelGqLYoHAZzXGBFMgl/n
 p5oNDE8HNxvq469w/CtTq4RZ0CqGhajiLKzdMepvEEX9/NREtjKc0o11oh7iz9wuxCa2XTPR2
 rvj3qflSQm7guZQOmPayUFhRBQjYmuYJjU+Ewjmdk/bF4BXdc3aTlVr+eFGq7l/evDt91VeKo
 mnVfbAYUOBs5uctZdj4QDFk1C1L773EJr4gtZuClF09p9bvTghyc/WMHsEdPW4d1pIlSvgwx+
 W/uiXeb6zMvpOvSUX0aFllVw579SIOdz58uvlR0zz8A2U36Dn2kVNAKbv4qrhQzx7ZGqXKbvP
 WZpQXM96c0P9J23qGFa1krs5bBuSxjWeYM6X+a3g5dC2a6kDjYPlNe0HV4K65ICko9yj6NX9u
 ECK1IIjEnYwqCrjgtmCQrsDsPjeo5izw7vu24Jc7BCt7RNveuzdAxCMnz9//MZHE9J2F+yYmt
 wfcLEHGh4xGkj/Z5XylKRCyI4/KSH4InF7q0SU8sLt20PKv261F/FUGFDlc=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594306372971918175?=
X-GMAIL-MSGID: =?utf-8?q?1594399049040926404?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Eric,

> Eric Anholt <eric@anholt.net> hat am 7. M=C3=A4rz 2018 um 19:57 geschrieb=
en:
>=20
>=20
> This was requested by Rob Herring in DT bindings review.
>=20
> Signed-off-by: Eric Anholt <eric@anholt.net>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

for Patches V2: #1, #4, #5

I'm okay with #6 as long as it's unused by any new driver.

Stefan
