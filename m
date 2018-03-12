Return-Path: <kernel-hardening-return-12465-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsZKWRxhY0TV18aK4OjzOs9ZLfkv9WkSS68Y6mbQdHTNQxh7KBoY4JqBiuJwgUdEgGrHuyA
ARC-Seal: i=1; a=rsa-sha256; t=1520870690; cv=none;
        d=google.com; s=arc-20160816;
        b=BoaVOZsOdlk19N+Co3GoZf/geg0WKKejSU+tp42OyUCbMUPs7EyFG8pMNNh4R6RCFl
         2F7I/8uzX5zmptwe25KP0PZQX3JKowyESX3/iQVl5DM2DF8YrFHkexNrRFM/ynPSKY0I
         n+w545zPm3djmNCAmFKh9PJR6tfpjQbPVAGwZhqjPVRnLgfSk/ljwkN3lp+snTv3yJdN
         sb+lLmsbSdz1Q76BixYgb7askhx+8fNTxN2B1mWHq92NgZjcDN/rhSDRCnvvagzTMZ4a
         MbO1F/EzwBYDTjjAoDRjcDWK1tVeFm90xoTqetP4Rgg/KeqKOEqTcZk6RH1ZwRSNIPSu
         0aEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:cms-type:content-transfer-encoding:mime-version
         :in-reply-to:user-agent:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Q7e/kL8m0ftr0o1MhvrQ2Ff0TCXjY9608F2k/XNpqqo=;
        b=ePGUVdcdf5nEfKpQ0um12Hv9fOwBm0Tdvx0Pym3YwgoVRTGZ9c/ZQe+rhAxfCWS3UD
         C406ZXNH2c6GSo0IPh6ruUbzTwCgscIrZcWpwo/vLxbKKr3bJqPBNyKbmNt5UyRkZo/o
         PCP2JI/hw+OZ0klsMInkuTrE3F+gdZyapyYVVXTR4NChhou1k0qonxVVUR0eSzzz6bHh
         aC+J8P+7lhkY9PAHe6F/U1hspm7eLThwjfKH3f0okoCaKpVEnGy4cCxgK8339w4rZ7vU
         a9xW4sXyljdvog3blh1xEibmNUxmI7idJKNwAgWJxm0/iKTcTasg1qMZAYOlqxn4VweB
         VEaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=Vvnn7DgM;
       spf=pass (google.com: domain of kernel-hardening-return-12465-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12465-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=Vvnn7DgM;
       spf=pass (google.com: domain of kernel-hardening-return-12465-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12465-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180312160428epoutp01ae280d74797d9da168db7a850d4ada17~bN9DBjSpm2232622326epoutp01L
X-AuditID: b6c32a37-433ff70000001029-09-5aa6a50cfddd
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Emil Velikov <emil.l.velikov@gmail.com>, Eric Engestrom
	<eric.engestrom@imgtec.com>, Florian Tobias Schandinat
	<FlorianSchandinat@gmx.de>, linux-fbdev <linux-fbdev@vger.kernel.org>, Kees
	Cook <keescook@chromium.org>, kernel-hardening@lists.openwall.com,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, ML
	dri-devel <dri-devel@lists.freedesktop.org>, "Gustavo A. R. Silva"
	<garsilva@embeddedor.com>
Subject: Re: [PATCH] video: fbdev: via: remove VLA usage
Date: Mon, 12 Mar 2018 17:04:25 +0100
Message-id: <7211546.mLmn3tHjVa@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <CACvgo5278SmXfV0jfrMu=Ba6gf7rRXzNduNX+D270fGUFQcZdQ@mail.gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7bCmgS7P0mVRBsc3a1tc+fqezWLP1XtM
	FmtaNjJZdM68xmixcsl+Noute1QtznTnWiz99JvN4kTfB1aLy7vmsDlwecxuuMjise6gqsfO
	WXfZPT58jPPo2XmG0eN+93Emj5Wdj9k8Pm+SC+CI4rJJSc3JLEst0rdL4MqY/aSXreAGe8WH
	jS1MDYyz2boYOTkkBEwkbmx/x9jFyMUhJLCDUWLHtgnsEM53RomP/+cwwlRdP9/DCpHYwChx
	7t1qZgjnK6PEiYndzCBVbAJWEhPbV4F1iAgYScye0Q3WwSywjlni4Kx1LCAJYQELiTvPbwIt
	5+BgEVCV+P2MHSTMK6Ap8eP5aiYQW1TAS2LLvnYwm1MgWOLaj3csEDWCEj8m3wOzmQXkJfbt
	n8oKYetInD22DuwHCYHnbBL9dzcwQZztInFu0hJWCFtY4tXxLewgeyUEpCUuHbWFqG9mlPi2
	Yw8zRM0ERok964UgbGuJw8cvQi3gk3j3FeR9kF5eiY42qBIPiRNHJzBChB0lZh1MgYTJaUaJ
	3c1bWCYwys5CcvYsJGfPQnL2AkbmVYxiqQXFuempxYYFxnrFibnFpXnpesn5uZsYwYlFy3wH
	44ZzPocYBTgYlXh4DZqXRQmxJpYVV+YeYpTgYFYS4fWfChTiTUmsrEotyo8vKs1JLT7EKM3B
	oiTOGxDgEiUkkJ5YkpqdmlqQWgSTZeLglGpgzEz20X67aFFfgduj2MD1a38t3bHURSDslsKW
	ng0dhpeuvZJcsi29Uvbt/PZ3eyx+/3YKeGwZyvXRiYW3QlpFe/rm57IzlNfGTqsIWH1QdVpR
	hlgg//e3J1S3vwo+tJxPY4ldTtmEZI05xnKZD5POFepPk1wVfvP8nSuqt+fe1ch8Hq3MrnXI
	WomlOCPRUIu5qDgRAORmi64oAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsVy+t9jQV2epcuiDBa3MVtc+fqezWLP1XtM
	FmtaNjJZdM68xmixcsl+Noute1QtznTnWiz99JvN4kTfB1aLy7vmsDlwecxuuMjise6gqsfO
	WXfZPT58jPPo2XmG0eN+93Emj5Wdj9k8Pm+SC+CI4rJJSc3JLEst0rdL4MqY/aSXreAGe8WH
	jS1MDYyz2boYOTkkBEwkrp/vYe1i5OIQEljHKDFlwzJmCOcro8ST5jeMIFVsAlYSE9tXgdki
	AkYSs2d0g3UwC2xgljj/ewsrSEJYwELizvObQGM5OFgEVCV+P2MHCfMKaEr8eL6aCcQWFfCS
	2LKvHczmFAiWuHx7IViNkMBpRokfF/0g6gUlfky+xwJiMwvIS+zbP5UVwtaSWL/zONMERv5Z
	SMpmISmbhaRsASPzKkbJ1ILi3PTcYqMCw7zUcr3ixNzi0rx0veT83E2MwFjYdlirbwfj/SXx
	hxgFOBiVeHg7WpdFCbEmlhVX5h5ilOBgVhLh9Z8KFOJNSaysSi3Kjy8qzUktPsQozcGiJM57
	O+9YpJBAemJJanZqakFqEUyWiYNTqoGR8cfK//Hplfpei6a4fuRodL6WlFxT7H4wvNphUUzD
	1hO9loG5xlUh2Y/e3ygW4rssdrFY9VFfHEP57bTWlRcXpmuq7+Y9f+5lrMv2N9ZM035pxKw0
	2jWp/6Wv+ULRvfI2bq3+9t+UzD33h57oj9wrVX3sM1c2i8C5awf+vAk6qcWh/jLpS7MSS3FG
	oqEWc1FxIgDf/cIggQIAAA==
X-CMS-MailID: 20180312160428epcas1p224161aa34ca46cdaecc65ee4d16552eb
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180309110234epcas1p2c64b608487008f178d25609e962ecc74
X-RootMTR: 20180309110234epcas1p2c64b608487008f178d25609e962ecc74
References: <20180308173949.GA19305@embeddedgus>
	<CGME20180309110234epcas1p2c64b608487008f178d25609e962ecc74@epcas1p2.samsung.com>
	<CACvgo5278SmXfV0jfrMu=Ba6gf7rRXzNduNX+D270fGUFQcZdQ@mail.gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594392120539391557?=
X-GMAIL-MSGID: =?utf-8?q?1594748505497598299?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Friday, March 09, 2018 11:02:24 AM Emil Velikov wrote:
> On 9 March 2018 at 10:59, Eric Engestrom <eric.engestrom@imgtec.com> wrote:
> > On Thursday, 2018-03-08 11:39:49 -0600, Gustavo A. R. Silva wrote:
> >> In preparation to enabling -Wvla, remove VLA usage.
> >>
> >> Also, fixed as part of the directive to remove all VLAs from
> >> the kernel: https://lkml.org/lkml/2018/3/7/621
> >>
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >
> > Sorry for my reply on v1, I missed that Emil already replied to another
> > post of the same patch (side note on that, making use of `-vX` and
> > `--in-reply-to` helps track the evolution of patches)
> >
> > This looks good to me:
> > Reviewed-by: Eric Engestrom <eric.engestrom@imgtec.com>
> >
> Same here
> Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
