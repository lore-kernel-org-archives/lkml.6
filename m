Return-Path: <kernel-hardening-return-12629-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuS7jb6jNeJI5ySUlOdBbVk7Ka9EPqOrIlmFLORq87JP+8UmO8aCprGKYXNm34vcwaMOyFU
ARC-Seal: i=1; a=rsa-sha256; t=1521113968; cv=none;
        d=google.com; s=arc-20160816;
        b=iHAZkIKdVx0cscoctGrQkOZ2GxeeLnrf7Ti9bp7DKulLhKifr30jB1V4we6nl8wsKU
         FzqS87Nu+K8a2EpXqv/R9xdIiERbh/ceV9utXsGL9MUbJjTuM+KNw0HS8ITLhW96PhoC
         bkGLtHsR5Ranu+GXpHYtjF677601C8wuKOu1PHGXBeXLpsCsGnYkMDFi5+o5YOeVmB3N
         NaBxUWrFkdMwVwq4i6AADCaKSvTmUMMr6YUcsr2+m3zYaSU+e8ufDblzfRdkNYVwAlZl
         wcAh3SbTsXlBBBkkOoW6OlgYiDx2BT9BOYQ6aQMQ/lbmFBQiDOO7xW00YZLLLaocuI6l
         Ridg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=JL73iYqUoKP3WXKCJnJS609pafuK/i9m1KQljQCmleM=;
        b=vyFWmIASBRi0xgrUvbUxi7T6zCKKAs9vvcgBo4T4fNi9e4r+xgfdSttcv5qoiyH/Ai
         cvE6uu5+dneZnCb6H6znXJixpExl4Ga38YBdtY5xziYqgcX9wqZ8TKMK6cgNBHlYYBuL
         lQdrNnQ3qz34qMC2sildjmc/pHtxcnLo2oQnTyz/MEt0G8LrLaCC28QO6U/ZJiurdJht
         +X2vECLaMNqXqAlp4V3juKPUL/BYk3zib+mNL/nJTNa+wXlUuHytteJfd/ny35ijIsT3
         nyBGtR775Qq5GwWhFknBQSdCoTsQ+QyqW0bCT0ntHFJHaZPaDdj7gOKIUINOTf94fJmQ
         MfAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12629-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12629-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12629-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12629-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: David Laight <David.Laight@ACULAB.COM>
To: "'Martin K. Petersen'" <martin.petersen@oracle.com>, Stephen Kitt
	<steve@sk2.org>
CC: "hare@suse.com" <hare@suse.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "kernel-hardening@lists.openwall.com"
	<kernel-hardening@lists.openwall.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] bfa: remove VLA
Thread-Topic: [PATCH] bfa: remove VLA
Thread-Index: AQHTvBeGEJGXEa7ONkidGyb1MqLdgqPRLCRg
Date: Thu, 15 Mar 2018 11:40:05 +0000
Message-ID: <32130f556f09408686626c50c70b39c9@AcuMS.aculab.com>
References: <20180308213841.13807-1-steve@sk2.org>
 <yq18tau7y4f.fsf@oracle.com>
In-Reply-To: <yq18tau7y4f.fsf@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594407144538028292?=
X-GMAIL-MSGID: =?utf-8?q?1595003600682002136?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> > -		sizeof(wwn_t[iocmd->nports])) !=3D BFA_STATUS_OK) {
> > +		sizeof(wwn_t) * iocmd->nports) !=3D BFA_STATUS_OK) {
>=20
> These parentheses made me blurry eyed but it's actually OK.

		iocmd->nports * sizeof(wwn_t)) !=3D BFA_STATUS_OK) {

is easier to focus on :-)

	David
