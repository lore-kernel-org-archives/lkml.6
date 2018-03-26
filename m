Return-Path: <heiko@sntech.de>
X-Google-Smtp-Source: AG47ELu5X5ldRmW3nXQvRqxOo3Q0LInXEtVQ41O48hDsa7IMaVRQ2x1YKbhY6Qbi32POTp6FwcUt
ARC-Seal: i=1; a=rsa-sha256; t=1522065071; cv=none;
        d=google.com; s=arc-20160816;
        b=0xyPwLsNkNYiLJL4Ah2OKzoes7CneKvSWgDDxRJ8kAc4BL95HiSv7rzzKpFQsX9If+
         mZDMhLMRjLJTvBK+sK25xxdUyy3sXjQAuqn9yd2VQEfcZVL5WpVUZY3X/4zeHHu6s0C+
         IBpEW3bW6eFzPQe/28Vlja2EyWvg0aicahiIMcjx2dDWva3dazwdMiuk3gHMSkEwaTf1
         gf9ZXMoYTr3w7OV4OOLUHMFB0c8/ycjuIdauFzgDnYkPMqOH4kH290vXtgHDMsAg7u/v
         UvRGvapmwzwEQDvWyEDTAONOvpG8RkFL05LFKbjQw5SjMlaHwbrdTn1lZHeFlqeLgXMu
         QQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=nymBPtCsL+LcHz4TokV0CLYX5rhCLZ0kDoFWfKFBN3M=;
        b=hqhJU7HHff7iTy6hBszxUmA0KVpgmvIA5KTU0YVhh4srWG6XActsWCauA0ScN4ICbE
         +1YAT/x6cpQmCYimf527JfpFrCCyOjEARsVTllBukdFXLS5iD4JhaYQLntFBPZd2m5nZ
         qN+KJWDsns1puaEPmn0ym/O+taLltiXzWAAsG8cKLPlmyVKarDbTbLy/D7tgNCtwtLD2
         2dbXm/LSF0JvoPX9QDE3HwZ8CpsVk7bC7KoEk3sY05ActMy5uet+OmW2XmtH/livAWoj
         n0G+aXm7lTFfDBZH9tMi7k2UmuatpmoGHsf5smwQsbNx3UJ9ojIJjollnPy8pitf9NAT
         qLPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heiko@sntech.de designates 95.129.55.99 as permitted sender) smtp.mailfrom=heiko@sntech.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heiko@sntech.de designates 95.129.55.99 as permitted sender) smtp.mailfrom=heiko@sntech.de
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Felipe Balbi <felipe.balbi@linux.intel.com>, Amelie Delaunay <amelie.delaunay@st.com>, Minas Harutyunyan <hminas@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH v4] usb: dwc2: dwc2_vbus_supply_init: fix error check
Date: Mon, 26 Mar 2018 13:51:05 +0200
Message-ID: <2158461.zz8sS7CZ86@diego>
In-Reply-To: <20180326090001.57627-1-tomeu.vizoso@collabora.com>
References: <20180322093943.49717-1-tomeu.vizoso@collabora.com> <20180326090001.57627-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595630296773142922?=
X-GMAIL-MSGID: =?utf-8?q?1596000904881087544?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Montag, 26. M=E4rz 2018, 11:00:01 CEST schrieb Tomeu Vizoso:
> devm_regulator_get_optional returns -ENODEV if the regulator isn't
> there, so if that's the case we have to make sure not to leave -ENODEV
> in the regulator pointer.
>=20
> Also, make sure we return 0 in that case, but correctly propagate any
> other errors. Also propagate the error from _dwc2_hcd_start.
>=20
> Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external vbus
> supply") Cc: Amelie Delaunay <amelie.delaunay@st.com>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
