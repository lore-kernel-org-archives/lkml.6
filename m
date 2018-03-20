Return-Path: <sboyd@kernel.org>
X-Google-Smtp-Source: AG47ELvbXvL6pXSsIAGJdbK91nUrE0eovBDWH/sfpczJNQmw7Q310logECj299AGbtWt7IYGnxL7
ARC-Seal: i=1; a=rsa-sha256; t=1521562933; cv=none;
        d=google.com; s=arc-20160816;
        b=AP4bedVZfBn6pdCboPL7JT3zcTKNSw/KBb9FNM4othsXOstNzVzrv0Kb0P5HofsAQs
         9x/T/LniDcvU/SmBFsoLWtSxSQODWv6FLrXu4KOrkWo5Rvkmi/Ck3XFJ2A1cf33tXDX4
         M1BdnsLdYBKM82TUy2yIdWHgfmLoBrJeTzR4r8X6ecEJCFjsEwezdRiQR7n9YQEEcfEs
         y3iAjjXxjEKTQiCkbN5D2MNVqKypdJRIuh37fgAGv3p/38m1wMH8b0SFyz3piceirW2s
         2Y2T7XN96FhyjJkNu51FVr3EFl5B5grAcWO595cQI6z23nX+9Dgng6Hzf3EZx4a9l7Qa
         +xMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:subject:user-agent:message-id:references:cc:in-reply-to:from
         :to:content-transfer-encoding:mime-version:dmarc-filter
         :arc-authentication-results;
        bh=ka8570cYCNRJBCua5XeP/vIZyz1RPL9m9hBwryS7wOk=;
        b=yWUoTCkSuDuGyZwRaMmmCKqj+v3OFh31C2YQdpP3pQNexYTknZcvjtKdpghuRjnhg7
         Azo3XKJeFQ9EVc2EZBq1KoyXGVjJp1C2AHpnwx2uSK0bJfoYptnKEwJP11LNjLWVxypg
         31P8qCqjHEap13p8c/OF+CIq4h/BoCg15P2GY+bGZKZRJXMmHQLh2yN8h7kFeirEx1oN
         GaxQLcy1Pq1drcVUBnbT0/Niut9bmZuPhAZpdBSSIfhU/o0IkNpx8AKcjcxEkG7kCVdX
         QG+aj9B8BW/aOYWoN29yy/0O1OTXu5wgAcSXgs+x3CYD7XeEq4mQoJRh4mOvYdu7TQV7
         NIow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of sboyd@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=sboyd@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of sboyd@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=sboyd@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF7521770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: ALKML <linux-arm-kernel@lists.infradead.org>,
 DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <6b5a56f7-ff0d-dde2-097b-bf245971e8a6@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Alexey Klimov <klimov.linux@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>,
 linux-clk@vger.kernel.org
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
 <1519403030-21189-17-git-send-email-sudeep.holla@arm.com>
 <152124137391.242365.17144416413429914606@swboyd.mtv.corp.google.com>
 <6b5a56f7-ff0d-dde2-097b-bf245971e8a6@arm.com>
Message-ID: <152156293212.254778.7714453841547508122@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 16/20] clk: add support for clocks provided by SCMI
Date: Tue, 20 Mar 2018 09:22:12 -0700
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209598817960240?=
X-GMAIL-MSGID: =?utf-8?q?1595474373920401631?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Sudeep Holla (2018-03-20 05:08:51)
> =

> >> +}
> >> +
> >> +static void scmi_clocks_remove(struct scmi_device *sdev)
> >> +{
> >> +       struct device *dev =3D &sdev->dev;
> >> +       struct device_node *np =3D dev->of_node;
> >> +
> >> +       of_clk_del_provider(np);
> >> +}
> >> +
> > =

> > Drop?
> > =

> =

> Sure, I will have to do these changes as add-on patch as this original
> patch is already queued in ARM SoC tree for v4.17
> =


Ok!
