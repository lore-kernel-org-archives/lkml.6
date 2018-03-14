Return-Path: <kernel-hardening-return-12568-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuIN5CJcyTlsRkIGNOcNbcJlYf95q8gj0039qbUjEje24YJsNUApAW8GLneO5u5/NVgz8N7
ARC-Seal: i=1; a=rsa-sha256; t=1520990547; cv=none;
        d=google.com; s=arc-20160816;
        b=kzvH/06mg/psl9YUm/DpUmX0w5jffsFS8teJUk1P4VQfC3x9ozAgl9zw9Whyr/kGS3
         lem/Cpzp38cgB5IbN6LzJ337K6T219BzPsRpez90LUrPK8MPO4TxiW0yWKtM9l7ZUsit
         IFVImGoGop6HSA2+smGHdjv4B8ZfOCPvIyVcKDo1fRT3dR4AqNmDwsKtjrkfiDZPx1r7
         dtqhbrKMAmMKYsH0ePgW7HifNETZiU9zAl430gQeJxBTlbOn+bSnaAXOmrZyXkTqdmJ/
         uIWRaaXRZ3+C3FYUO4tpKB703803Drt8fzD6DjSSoEgWg9M7y3RLVVs7AWRifzfu7M0n
         kciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=CyxltPXvf2muZAlYOeAgnn0e4k6F004O4dohh444i1U=;
        b=DcxYO92IwXaf+9itKVKG3PGEDScA2guyar9JROk0oXcPFEX1qxKdQQu+mcqsPTrxIT
         NF9WSs0x6Y2ADP7qsF2kQcpDunhh9DrTQzU85aDW7HtGeBRdVs7MKZtu/Y+AAmNpPgQ7
         M0sLnMxcA/f3JnFbD6yTup+DG362hF7q3skEGTzbNh2EwWrkrV4pacmH3heTBie9q9Io
         MclDT+GFJJbwUUblEKZdfS3nLnL1ifhgA/BmNU8BaSyiEVRoOa9rx97alokdbeQdqfjg
         Zwad6UnV+ow1KN4URuHKudSW8AeDb1dZzvvjWM5u1WvnzNQ/4btSD8YWeHNo2ndeeVUt
         iKkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=poA3m1kG;
       spf=pass (google.com: domain of kernel-hardening-return-12568-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12568-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=poA3m1kG;
       spf=pass (google.com: domain of kernel-hardening-return-12568-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12568-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <CA+DvKQK9jRe5YOk_K4DzBYkh2VUys56XbaYZRGs0fn2WJNT+nQ@mail.gmail.com>
References: <1520598613-3641-1-git-send-email-andreaschristofo@gmail.com>
 <5AA464DE.90100@broadcom.com> <CA+DvKQ+hbMoWJdOuQB5n+eVF4ePf=kVuRiMbdtTUZ8ars4Pz4A@mail.gmail.com>
 <423b529d48c54eba9f7ed51922814d46@AcuMS.aculab.com> <CA+DvKQK9jRe5YOk_K4DzBYkh2VUys56XbaYZRGs0fn2WJNT+nQ@mail.gmail.com>
From: Daniel Micay <danielmicay@gmail.com>
Date: Tue, 13 Mar 2018 21:22:08 -0400
Message-ID: <CA+DvKQJYMYCVgxZPxqCnkZn2u-sunSUF6ZTTDJ0sauhX-1qEzw@mail.gmail.com>
Subject: Re: [PATCH] drivers: net: wireless: ath: ath9: dfs: remove VLA usage
To: David Laight <David.Laight@aculab.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Andreas Christoforou <andreaschristofo@gmail.com>, Kees Cook <keescook@chromium.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	QCA ath9k Development <ath9k-devel@qca.qualcomm.com>, Kalle Valo <kvalo@codeaurora.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594463764603415966?=
X-GMAIL-MSGID: =?utf-8?q?1594874184107076602?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> I don't think the difference between C and C++ const pointer
> conversions

I mean I don't think the difference between them was intended.
