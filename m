Return-Path: <caizhiyong@hisilicon.com>
X-Google-Smtp-Source: AB8JxZofAnNZRCZNJQ5aB40/qys8WQ9GqSv4f8gNA9OqXkDtiSQY3cqrXSzVZBPHXoBz2spQ4fdT
ARC-Seal: i=1; a=rsa-sha256; t=1525417695; cv=none;
        d=google.com; s=arc-20160816;
        b=sgfhU+Ygoabb2dvxusd7aB4MW1/2ZKqbUYzZ5E3oIyMnUN27VL4iTqcgMZbzXaCMHA
         kUjWP0NNMevySHLFuJE6Rtf5Rda4BJsJ9amABN5Z7LK3ZuBM/M7DbqwDcfDEOMCB7J8n
         6SoStPcBzFGB1rwUNpSNQ4qmwdKDj6gTYfpw1yfTlQ1vYF38EbF9Pl+7eW0F9tYmGsD+
         SB061afMTiQW23H6Wn05CoVf1cZR1/KRscAt0yj8Z71y3CLUkHwKqxCihDodMgO5678S
         y1X4G0CPjeez9CiM2LuVmnojsDUlqK3ypHDsckbebMCD1D45PZRdcVwpHRQ1EOIsrW7t
         bmXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=qK4YiN5WGcVyUFwf4FZEoOr1q5HJoXMNchNvU2NZeUU=;
        b=MIxzcMrKCLFMjJirX6A9HpOyUzcwDq4qKQyC1xsFgngKBtz/Ecpzznt70OAlT2RWDw
         28rpTKPnRyVIT+iD4jDX7+SFDc9VDVqv6sazk58wJijP75Fp5DZyMV3810eM2R6Fq9z9
         1LKUydiAzE9I2JfoiSISt/sgahkacqUa+V06EEIQQF5IzBvYNQeFxIxm8oAk30mDM0qg
         LuRNWvDFIEeXrfE5b6Z18j2hVoZ9d69pyqiCrsRgLH7oaOPLweFNKikQnxKvdHOu4wp3
         cTvuKoyPXR4QUneGbt3+reWxYYc9Pu3HaMG1f38x6d1dIc1ckRDQUZHekL2kxG+mCIJG
         WMJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of caizhiyong@hisilicon.com designates 45.249.212.187 as permitted sender) smtp.mailfrom=caizhiyong@hisilicon.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of caizhiyong@hisilicon.com designates 45.249.212.187 as permitted sender) smtp.mailfrom=caizhiyong@hisilicon.com
From: Caizhiyong <caizhiyong@hisilicon.com>
To: Wang YanQing <udknight@gmail.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"pombredanne@nexb.com" <pombredanne@nexb.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jiangheng <jiangheng@hisilicon.com>
Subject: RE: [PATCH] block: add verifier for cmdline partition
Thread-Topic: [PATCH] block: add verifier for cmdline partition
Thread-Index: AQHT4tBgqIcfQVx8gUSka4WV0zpU+6QfJOHA
Date: Fri, 4 May 2018 07:07:30 +0000
Message-ID: <C3050A4DBA34F345975765E43127F10F8B77159A@dggemm511-mbs.china.huawei.com>
References: <20180503111748.GA904@udknight>
In-Reply-To: <20180503111748.GA904@udknight>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.217.112]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599441484038057319?=
X-GMAIL-MSGID: =?utf-8?q?1599516385704704503?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: Wang YanQing [mailto:udknight@gmail.com]
> Sent: Thursday, May 03, 2018 7:18 PM
> To: axboe@kernel.dk
> Cc: gregkh@linuxfoundation.org; pombredanne@nexb.com;
> tglx@linutronix.de; Caizhiyong <caizhiyong@hisilicon.com>; linux-
> block@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] block: add verifier for cmdline partition
>=20
> I meet strange filesystem corruption issue recently, the reason
> is there are overlaps partitions in cmdline partition argument.
>=20
> This patch add verifier for cmdline partition, then if there are
> overlaps partitions, cmdline_partition will return error and log
> a error message.
>=20

Partition overlap was intentionally designed in this cmdline partition.
some time, the cmdline partition save raw data(not filesystem), the overlap=
 makes data  access very convenient.

reference  http://lists.infradead.org/pipermail/linux-mtd/2013-August/04809=
2.html

> Signed-off-by: Wang YanQing <udknight@gmail.com>
> ---
>  block/partitions/cmdline.c | 63
> +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 1 deletion(-)
>=20
