Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9680FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAEC20449
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8EjYQsf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfA1O1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:27:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52374 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1O1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:27:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so14204536wml.2;
        Mon, 28 Jan 2019 06:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VEvcffBWdOWN6PdoAFgZWZE1ZkFcnJULt+GhahYN0uU=;
        b=m8EjYQsfngRjsU+d70kTaJ0q5ecOtODTVnEPu+s5iDQkjiQuG6jg5c7rOvJSU7BVmi
         ifj8d6gvuYD6z7+LFfqqxfc1ydOKWUYbVaB/VLEnkL5jMHor+v3Zt3lpTXYxN2mh1Qag
         DgqobxgrhKnvAW+GhjsKVFvVLMVtNNnXTUn1P+GlF88eJ306QKcqvUVZBv5XTfeQz8Ds
         m5g6Zyb8uHeJ2UBF7q3VE3P+UH0Tj352gj4I6M8bnp5kMwieTtUOfA+3+DVHzcu+Rwjq
         +Ie5YjAq4y/rVYCmytsTkWQmqdDb6jo/dO+stM2TczLU8eH37zC05ZfprXBG2ZFWVaGd
         UXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VEvcffBWdOWN6PdoAFgZWZE1ZkFcnJULt+GhahYN0uU=;
        b=F8/l3eJeCWHTFR2QC938McuQ6VngGzOvHJ2e14Im0JtkSclaWI0z8578DFao2B8J1t
         xpdBbuEuLCGAsTfelT+957fey44Hu7+/DyzVb3ypVk2uRRnk7xaxvPiNGwRIyB9F0MoS
         HC6AdmtMn5SGR40IlmQ19bwcb6pjZyAYcibTO6+Sgb/z6snM2CopvzNCMQ0K9tTOntCC
         wIEEoJPJJgzCwcRl+lSTti/M2+o4HnmInrD9qxW5IujHEllT+2CblsyWxWae3tJDCHQF
         ShnAMo0qrXgetrAdl3aH1mxXPOxf2NkZAl/9buqWruSUycGi9uwKJngAGRdjxWOojW3J
         0SMg==
X-Gm-Message-State: AJcUukcYRNE8OrPBYhyZ2+agIO/jRj5l17UZfepNOJpLrQm2NCl5VBA1
        ZSrD53IStwtrPh+5BlHV5wWGJuq+
X-Google-Smtp-Source: ALg8bN4kLImeXOgK6wmYZdWFhoJrFrYCogoIzUjRtplrcSBkncx2V2uC2A+mMrFZLdp3sesvvYAPKQ==
X-Received: by 2002:a1c:dd04:: with SMTP id u4mr17288833wmg.84.1548685623197;
        Mon, 28 Jan 2019 06:27:03 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id n9sm91391088wrx.80.2019.01.28.06.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 06:27:02 -0800 (PST)
Date:   Mon, 28 Jan 2019 15:27:01 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Mattias Jacobsson <2pi@mok.nu>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        michal.lkml@markovi.net, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] platform/x86: wmi: add WMI support to
 MODULE_DEVICE_TABLE()
Message-ID: <20190128142701.xj4vwiind4ddbcj6@pali>
References: <cover.1548610407.git.2pi@mok.nu>
 <680df320c7263bdd35f87794ae12fb9a9ef3b71c.1548610407.git.2pi@mok.nu>
 <CAHp75VfE0g9OVeOzJ5fBj4MGL4nv=a4S-n1fD9kfP1AaniAOGw@mail.gmail.com>
 <20190128140911.xsltdctpk3bya7ya@mok.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190128140911.xsltdctpk3bya7ya@mok.nu>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 January 2019 15:09:11 Mattias Jacobsson wrote:
> Hi,
> 
> On 2019-01-27, Andy Shevchenko wrote:
> > On Sun, Jan 27, 2019 at 9:04 PM Mattias Jacobsson <2pi@mok.nu> wrote:
> > >
> > > The kernel provides the macro MODULE_DEVICE_TABLE() where driver authors
> > > can specify their device type and their array of device_ids and thereby
> > > trigger the generation of the appropriate MODULE_ALIAS() output. This is
> > > opposed to having to specify one MODULE_ALIAS() for each device. The WMI
> > > device type is currently not supported.
> > >
> > > While using MODULE_DEVICE_TABLE() does increase the complexity as well
> > > as spreading out the implementation across the kernel, it does come with
> > > some benefits too;
> > > * It makes different drivers look more similar; if you can specify the
> > >   array of device_ids any device type specific input to MODULE_ALIAS()
> > >   will automatically be generated for you.
> > > * It helps each driver avoid keeping multiple versions of the same
> > >   information in sync. That is, both the array of device_ids and the
> > >   potential multitude of MODULE_ALIAS()'s.
> > >
> > > Add WMI support to MODULE_DEVICE_TABLE() by adding info about struct
> > > wmi_device_id in devicetable-offsets.c and add a WMI entry point in
> > > file2alias.c.
> > >
> > > The type argument for MODULE_DEVICE_TABLE(type, name) is wmi.
> > 
> > > +/* Looks like: wmi:guid */
> > > +static int do_wmi_entry(const char *filename, void *symval, char *alias)
> > > +{
> > > +       DEF_FIELD_ADDR(symval, wmi_device_id, guid_string);
> > > +       if (strlen(*guid_string) != WMI_GUID_STRING_LEN) {
> > > +               warn("Invalid WMI device id 'wmi:%s' in '%s'\n",
> > > +                               *guid_string, filename);
> > > +               return 0;
> > > +       }
> > 
> > > +       if (snprintf(alias, 500, WMI_MODULE_PREFIX "%s", *guid_string) < 0) {
> > 
> > What the point to use snprintf here with arbitrary buffer size if we
> > exactly know 2 facts:
> > 1. UUID string is  36 characters
> > 2. buffer is long enough
> > 
> > ?
> 
> As long as no one changes the code, not much.

At least instead of hardcoded number 500, you should use pass size of alias:

  static int do_wmi_entry(const char *filename, void *symval, char *alias, size_t alias_size)

  if (snprintf(alias, alias_size, WMI_MODULE_PREFIX "%s", *guid_string) < 0) {

Or pass buffer of constant size and then you do not need to use snprintf:

  #define ALIAS_SIZE (sizeof(WMI_MODULE_PREFIX)+WMI_GUID_STRING_LEN)

  static int do_wmi_entry(const char *filename, void *symval, char alias[ALIAS_SIZE])

This should not break even when code around changes.

> > 
> > > +               warn("Could not generate all MODULE_ALIAS's in '%s'\n",
> > > +                               filename);
> > > +               return 0;
> > > +       }
> > > +       return 1;
> > > +}
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> 
> Thanks,
> Mattias

-- 
Pali Rohár
pali.rohar@gmail.com
