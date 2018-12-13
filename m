Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CC2C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9050220870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Do10Yxbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9050220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeLMLFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:05:09 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43194 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbeLMLFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:05:09 -0500
Received: by mail-qk1-f194.google.com with SMTP id r71so838348qkr.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 03:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1jh9HCRlfdUpdhUd9VEjN/Jz5qM6DGrErFc3K9FQTGU=;
        b=Do10YxbnZZ3U1MnSrWpm+Eoj5GANYxgEQduot7S1jutz5FxLZwQWltUPJfemRlmMFU
         vDi4sgh4HuwufmwODWoMjQvVYYKoQ81wC3nEZ678wGpmciH166XQ/UHyNH04tWFHsX8Y
         Y0QSIoU41n6da+AZVrpneOtf6HuetFYHlZ8A12QE3stkAeT/0pHpEPuk50gNutQeTeoa
         REcoG0XSU+RGO/8rsSfr2NAOv5rfkkpcBZwNh2UJIk6EjmCSfN5qcHpNC0ET9G9SJE7r
         dNJg65Ryu9svvg/volTZmT+LMcs44CWqdLi6RUOX2iywGGQ55In+nwcKTtzyl6BUu5/k
         H7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1jh9HCRlfdUpdhUd9VEjN/Jz5qM6DGrErFc3K9FQTGU=;
        b=RBAspNo5o+viPYYQyIUU5LPY/Gxl97VJA9mIbCwQ38TZBpbTC15ip4P80D2Ex/NEic
         c1YT14ichAQ1cv2FDw44Xu888wg493Yxfb3VmWBLdHiIQYoydwpttY/WDI0YCez4NM/N
         +W19105I100shnn8Ey1PTmQwI+KK54E+ZeXgcsQMs/xBF8fc8/P+Nfj/lFO4iO2OUmwK
         nv0DF6S5yYljLsri/DRYQv2xCZaR9hXBfwi92lt0Q3JtcdQDIZFcc0h1gOMhgXCGXlqy
         pVRuvc5GG3/Ko/Y+RTjmVu7LCRxNKwuf+YuPTwUZ3Kjz2Koj2sJsaPJymlu65lT+Usx3
         r7YQ==
X-Gm-Message-State: AA+aEWarD+U8UK3iOCTLz5mRgQ0Uem7QqT9XVM07UBAroZyDS0nODaz+
        LzysabTbNiDnzqXD3K2TvPQ18I1lEktv/PwBY8v+uA==
X-Google-Smtp-Source: AFSGD/VzdmCOBBXmNDf4XTCoFGb9aakr7u46LBAj6nBcTV+/as0noFKbJ9KKbATImQA5fDzP4JX/HK6QzHnafek15tg=
X-Received: by 2002:a37:6005:: with SMTP id u5mr10522341qkb.219.1544699106253;
 Thu, 13 Dec 2018 03:05:06 -0800 (PST)
MIME-Version: 1.0
References: <20181206030227.9507-1-kyletso@google.com> <AM5PR1001MB0994F844103F31DBD373AAB880A50@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <AM5PR1001MB099433159E3519D8F534E38F80A50@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <CAGZ6i=3+8OOafaY8B5qRkDg1pzpTu0XRw-GAenubY74DM=85Pw@mail.gmail.com> <AM5PR1001MB099418665806CE9FF06D138780A70@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM5PR1001MB099418665806CE9FF06D138780A70@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
From:   Kyle Tso <kyletso@google.com>
Date:   Thu, 13 Dec 2018 19:04:54 +0800
Message-ID: <CAGZ6i=0ksqGJgewdXJ+zHd_SMfUpHqZd2whFbaN2uYt7fRNzWQ@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Extend the matching rules on PPS APDO selection
To:     Adam.Thomson.Opensource@diasemi.com
Cc:     Guenter Roeck <linux@roeck-us.net>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        Badhri Jagan Sridharan <badhri@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 6:15 PM Adam Thomson
<Adam.Thomson.Opensource@diasemi.com> wrote:
>
> On 12 December 2018 02:47, Kyle Tso wrote:
>
> > On Mon, Dec 10, 2018 at 7:36 PM Adam Thomson
> > <Adam.Thomson.Opensource@diasemi.com> wrote:
> > >
> > > On 10 December 2018 09:01, Adam Thomson wrote:
> > >
> > > > On 06 December 2018 03:02, Kyle Tso wrote:
> > > >
> > > > > Current matching rules ensure that the voltage range of selected
> > > > > Source Capability is entirely within the range defined in one of
> > > > > the Sink Capabilities. This is reasonable but not practical
> > > > > because Sink may not support wide range of voltage when sinking
> > > > > power while Source could advertise its capabilities in raletively
> > > > > wider range. For example, a Source PDO advertising 3.3V-11V@3A (9V
> > > > > Prog of Fixed Nominal Voltage) will not be selected if the Sink
> > > > > requires 5V- 12V@3A PPS power. However, the Sink could work well
> > > > > if the requested voltage range in
> > > > RDOs is 5V-11V@3A.
> > > >
> > > > Is there a real world example of a sink requiring the 5V - 12V
> > > > range? In that scenario could we not add an additional sink
> > > > capability which allows for this range to be supported, and the current
> > implementation should work just fine?
> > >
> > > Ok, I maybe should have waited until after my morning coffee to
> > > respond. So because the lower limit on the sink side, is higher than
> > > the advertised source's PPS minimum voltage it never gets selected?
> > > Personally I'd prefer to keep the upper limit checking as is as I
> > > think that's an additional safety benefit helping to prevent
> > > over-voltage scenarios. I think if a PPS APDO can supply up to 11V
> > > then the system should be capable of handling that voltage, otherwise
> > > it shouldn't be considered at all. The Source provides limits checking
> > > as well to make sure the Sink doesn't request a value above the maximum
> > voltage limit for that selected APDO.
> > >
> >
> > If the over-voltage occurs, it means:
> > 1. the adapter malfunctioned. or
> > 2. the code on the Sink accidentally requests a voltage level which is over the limit
> > of the Sink.
> >
> > For 1., it is difficult to predict the behaviors of a malfunctioned adapter. The over-
> > voltage event may happen even if the Sink doesn't select the APDO from this
> > broken adapter.
>
> Yes, I agree it's almost impossible to do anything from software to mitigate
> this which is why the HW design has to have protection for this.
>
> > For 2., it is difficult to predict the behaviors from the careless code as well.
>
> Yes, that's also true, but if it's coded with the intention not to select an
> option that's potentially higher than the system can handle then we're less
> likely to fall foul of over-voltage scenarios in my opinion. By selecting a
> PPS APDO with an upper threshold which falls within the board limits, assuming
> the code were to accidentally request something higher than the PPS APDO maximum
> then the Source should reject this. Just feels a little safer as we're talking
> about controlling an external power source. At the end of the day though the
> decision lies with the maintainers on this.
>

The implementation of PPS in TCPM doesn't account for the decision of
the content
in each RDO. It is nearly fully passive and receives the key values
(voltage/current) from
external codes through the power_supply framework. There are already some basic
checks in TCPM which reject invalid requests from the external codes.

pps_data.min_volt
pps_data.max_volt
pps_data.max_curr

These values are set in tcpm_pd_select_pps_apdo() and they are
restricted within the
board limits (and vice versa if the limitation is on the source side).
I think it is enough
to protect it from careless external codes.

> > > For the lower limit I'm more inclined to agree with allowing a higher
> > > minimum on the sink side as that's less of a safety/damage issue as I
> > understand it.
> > > FWIW, what is the real world scenario? What happens if voltage drops below
> > 5V?
> > >
> >
> > Some products (in Sink mode) have under-voltage protection (the lower bound
> > might be around 3.8V - 4V before the calculation of IR-drop) that will cause the
> > disconnection.
>
> Ok, so the system would just stop charging, correct? I guess the calling code
> to control the Source/adapter, via TCPM, wouldn't select a value below 4V in that
> scenario anyway?

Yes, that's why I do these changes in this patch. It's weird if the
Sink claims its Sink
Capabilities with a wider range of voltage than it really can support.
But actually
many adapters (in market) have wider capabilities than this kind of Sink port.

thanks,
Kyle
