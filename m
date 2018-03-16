Return-Path: <sboyd@kernel.org>
X-Google-Smtp-Source: AG47ELvecRlVvpRiSUpPMH4V1tsij2pNA7gOdVCjcF9OGAcKkUKqybtQjzviNpHOQl1bH562/h0j
ARC-Seal: i=1; a=rsa-sha256; t=1521241374; cv=none;
        d=google.com; s=arc-20160816;
        b=nSbNzMvmQElAkYBj5NyqR7gSLycD4VpyX6ieTFBHPxpepfUKk+Tb0kD3HAf9luQxdP
         wAGWEoA+pdpnTRtHBMbBHQfGT44MfnsRpPMXh1b4dhL8iwII40Je+7mRKTzoh9RpyYDj
         FLrg4h+VniUW0oFrCEl3iVxOYRyworoOqaPCem4nFKCSp2r5qAmueBvB5nPG80+866ku
         xusNCiu6bY1GSo9roNXC6HB/ubkfASjScM2IKHAokb2uoX1wuHOxmprXvHzEB72qk1OU
         yswokLbXRSJimXCBChVLhzWFu1T5rvs5dHv9ky1LoLYb/+P2ueLJQihCPqxJYEkRCEJZ
         iuxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:subject:user-agent:message-id:references:cc:in-reply-to:from
         :to:content-transfer-encoding:mime-version:dmarc-filter
         :arc-authentication-results;
        bh=u+9H73bxhZduD56a0qK8ea63Z7LQuzM9F55rSANVa6s=;
        b=J0FkVL8FSSWG+9rJBEuRlrugRvnQLrZIvqXSf503SXZLJ04W64tA9ta3Q9Hhm0Pb1K
         vNubN7Hk2OCUEm/FhNpN/l2Fgr6YsimrIDqKwVivOWwSj4r0RU6VbqtvSrh3x9oJxGxK
         lBU+/HES6wMRaEcdXsRixUKOzOyN2oCxm1p4oafIh3PWqj4MGHnXiVjDOOVBE7VRjbYt
         fnjJ8QdO8QwOSNns/hz9I6nNF8JrSa+sabMlb2bzoX7+19JdcQ5pyRXqNa7MciQfc6Mw
         0S23MfDhsYVmGL8lAXhgBNs3hEvWjSDn/PJwW5vCBLT7GAsnrs3SKafx4q/kjtJ5m72z
         C1Aw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of sboyd@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=sboyd@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of sboyd@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=sboyd@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9157221742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: ALKML <linux-arm-kernel@lists.infradead.org>,
 DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1519403030-21189-17-git-send-email-sudeep.holla@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Alexey Klimov <klimov.linux@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>,
 linux-clk@vger.kernel.org
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
 <1519403030-21189-17-git-send-email-sudeep.holla@arm.com>
Message-ID: <152124137391.242365.17144416413429914606@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 16/20] clk: add support for clocks provided by SCMI
Date: Fri, 16 Mar 2018 16:02:53 -0700
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209598817960240?=
X-GMAIL-MSGID: =?utf-8?q?1595137196025836542?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Sudeep Holla (2018-02-23 08:23:46)
> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> new file mode 100644
> index 000000000000..1e4d7a57779b
> --- /dev/null
> +++ b/drivers/clk/clk-scmi.c
> +                       hws[idx] =3D &sclk->hw;
> +               }
> +       }
> +
> +       return of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data=
);

devm_of_clk_add_hw_provider?

> +}
> +
> +static void scmi_clocks_remove(struct scmi_device *sdev)
> +{
> +       struct device *dev =3D &sdev->dev;
> +       struct device_node *np =3D dev->of_node;
> +
> +       of_clk_del_provider(np);
> +}
> +

Drop?

You can keep my acked-by otherwise.
