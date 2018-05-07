Return-Path: <caizhiyong@hisilicon.com>
X-Google-Smtp-Source: AB8JxZrxfR0vvG9soKcIFbZTFqzn1ztq0q4W6mhBN4YCNdKVOHlB/iHFfpC0bi/4HUvvGstQqWr1
ARC-Seal: i=1; a=rsa-sha256; t=1525660260; cv=none;
        d=google.com; s=arc-20160816;
        b=JBOBLM2eQ1I9l3bcL+hsSCQn4qBun/XWD8Dtnla8OkusWkNY8+UTtOFJ0tdHuo1LAS
         YwfG/DwsYmOjt6O8MU3xwrhKtP2NsTo6cV5n6+RtQOdH3f2bJEG7O+p1kGZQ/KnT2snF
         sbbEvRsBKD+XtSZq2drCP8Go3+FvsXpwGCc2LS+eXzyhrWoyFz6HPe3VLVVUw7gqfGkE
         UQ3F3mjUJ2BBnWagMrZRZCmypWPT0n3C6NUolLKxfHjB5XsWQFkubpsUb4YbydtTlz6h
         EP/ViFthCLGR4QxRqAON/8hPHx/nRritGTodXNEZQ4OO2UowGwe9EjjPMQ808A/hMHMf
         bxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=sV8RTe1y4rJTs/xm8GhebWVACedQfUOyvAON/nCx+/Y=;
        b=y1wgJz7UmcUKgoRx4YVAegmcV0QHTvdv6Buu/bgF5SosJm2t8ME/4lSuEBUyZI2hJk
         INjE9StvEezUOD8bq9cxtvwYgssac6QePq533uJ+ZKlLvzL/2LaSF2WydGkSTRcmW8Nm
         CX2SEm6DhOpNsY0ZHJMOWaI87uxQuwX59AVyKSig6TcXr/0nVaFXWieHGoXo9CPiYqJb
         Ip5ag9NHGXcNxV6ckxG34pkAyQXjOeTRVi51EOlASYXofrXPSpTimQWew5BMTB2jSEcU
         THHACokzTX13iLHgCo5Yc89za68dO0IwU6lidCtS3dmD06UB+oMM0IhBhXVpuz0M5MYs
         Rs+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of caizhiyong@hisilicon.com designates 45.249.212.189 as permitted sender) smtp.mailfrom=caizhiyong@hisilicon.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of caizhiyong@hisilicon.com designates 45.249.212.189 as permitted sender) smtp.mailfrom=caizhiyong@hisilicon.com
From: Caizhiyong <caizhiyong@hisilicon.com>
To: Wang YanQing <udknight@gmail.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"pombredanne@nexb.com" <pombredanne@nexb.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jiangheng <jiangheng@hisilicon.com>
Subject: RE: [PATCH v3] block: add verifier for cmdline partition
Thread-Topic: [PATCH v3] block: add verifier for cmdline partition
Thread-Index: AQHT5PqY+KKQKUgW/0aJEG996SsL+qQjiy9A
Date: Mon, 7 May 2018 02:30:47 +0000
Message-ID: <C3050A4DBA34F345975765E43127F10F8B7720E8@dggemm511-mbs.china.huawei.com>
References: <20180506052356.GA11163@udknight>
In-Reply-To: <20180506052356.GA11163@udknight>
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
X-GMAIL-THRID: =?utf-8?q?1599689092526143942?=
X-GMAIL-MSGID: =?utf-8?q?1599770732878513601?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>  /*
>   * Purpose: allocate cmdline partitions.
>   * Returns:
> @@ -93,6 +158,7 @@ int cmdline_partition(struct parsed_partitions *state)
>  	disk_size =3D get_capacity(state->bdev->bd_disk) << 9;
>=20
>  	cmdline_parts_set(parts, disk_size, 1, add_part, (void *)state);
> +	cmdline_parts_verifier(1, (void *)state);

cmdline_parts_verifier(1, state);=20

>=20
>  	strlcat(state->pp_buf, "\n", PAGE_SIZE);
>=20
> --
> 1.8.5.6.2.g3d8a54e.dirty
