Return-Path: <davem@davemloft.net>
X-Google-Smtp-Source: AG47ELsoMxA0q9WkTUkIgc5zaeqdVvzJHdRCKqByXrt8IWIqIYYPooTWykRLDlpY60IphPFRmPr2
ARC-Seal: i=1; a=rsa-sha256; t=1521508515; cv=none;
        d=google.com; s=arc-20160816;
        b=E0g99pVZcHWhX+N4UmLsIsi91npBzLdgJT4mjY2UEsq3702WgetufN4Kv8Zn9APfJR
         SOaAkZ05gjdLwOO6Rqw/4JweVRhXj227REa40NnS6LZZ5WVqSaDRhSG8nrnu6XjsvnxQ
         yM3S98Pe9zR4PdRLJdYd9ktkV/LKyhN0P4yQRAghtIBkIb8szi9lLCfhPZOd8yjruz68
         L/99f/UGvSTf6i46NFawzMr95+fobqgw1kmThqR5bzT0yQNrUifedZ4KCLuejCBJhC9n
         d+4I2c04tlC42CoShs47QU874Lxe0c0RRHZ12K5uVLXlQP0I6AZ75YjBd905wJ1K4xOi
         ucig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:arc-authentication-results;
        bh=j/z6t7mNq4c9ud79a7YyAvB4OZEsr6KQJlhSvYw6a1Y=;
        b=j7SjGbvlPuN3Cm2ISUIXRaN3kDhrr3Cwg+mwqsBj0vXf3sYqVKyomLB8vab8RvKi0V
         fRulEeim8MIW7A12KSNHrYWIMk1fSsrdA9SrpPlnH6gPb3zYxSOPxjcNfm3wuXLcuJ81
         hpcRPLjhjpkw9dy7J7HpihjDGT64uHbg6HM7no2oOwxFpsif2aNKR3jnomdt6Q5/i0vu
         kjy3XxcAK/n1B5qj2ob883tHGFwhP+wkfPz4v4K2iTrmJcRQgjVvP3HJFqyUqkO6zVmc
         Rm3U/QwRNlNpZqtdMZLbnCU7dw0AbJNtd9FbsIxwqQFGBVYWoeXBXmKsycxPY3koSglC
         PK0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Date: Mon, 19 Mar 2018 21:15:12 -0400 (EDT)
Message-Id: <20180319.211512.2145226173040811016.davem@davemloft.net>
To: grygorii.strashko@ti.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 gregkh@linuxfoundation.org, nsekhar@ti.com, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 0/2] net: phy: relax error checking when creating
 sysfs link netdev->phydev
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180316220835.30006-1-grygorii.strashko@ti.com>
References: <20180316220835.30006-1-grygorii.strashko@ti.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595133782136044428?=
X-GMAIL-MSGID: =?utf-8?q?1595417313362916864?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Fri, 16 Mar 2018 17:08:33 -0500

> Some ethernet drivers (like TI CPSW) may connect and manage >1 Net PHYs per
> one netdevice, as result such drivers will produce warning during system
> boot and fail to connect second phy to netdevice when PHYLIB framework
> will try to create sysfs link netdev->phydev for second PHY
> in phy_attach_direct(), because sysfs link with the same name has been
> created already for the first PHY.
> As result, second CPSW external port will became unusable.
> This regression was introduced by commits:
> 5568363f0cb3 ("net: phy: Create sysfs reciprocal links for attached_dev/phydev"
> a3995460491d ("net: phy: Relax error checking on sysfs_create_link()"
> 
> Patch 1: exports sysfs_create_link_nowarn() function as preparation for Patch 2.
> Patch 2: relaxes error checking when PHYLIB framework is creating sysfs
> link netdev->phydev in phy_attach_direct(), suppresses warning by using
> sysfs_create_link_nowarn() and adds error message instead, so links creation
> failure is not fatal any more and system can continue working,
> which fixes TI CPSW issue and makes boot logs accessible
> in case of NFS boot, for example.

Series applied and queued up for -stable, thanks.
