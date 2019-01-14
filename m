Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3196C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1E0206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGAJH9FF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfANSkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:40:17 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46061 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfANSkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:40:17 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so9818375pgc.12;
        Mon, 14 Jan 2019 10:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n2vGYK44AUmiHPqV1mudOtym+BRnlJBLZRp8SzeWKLM=;
        b=XGAJH9FFWiZakNu7uhlSpzVQ44a0Rh1+slnV44HbP7A5KqCeHJYAJIOx+TdWMnOsxj
         BCUBtHLtEW03R6SpZwJ1zuuE+i/O5ECgxpT6vX/xZSGjpGln0i+k8/1BRl5xpb52YKrX
         AvKmvfFFI4oaA1B3e/DwhzhaoM+D6i3pTPbgnx2QJkXlPwsmNm3+8WMotkewayBMjT9J
         doDF/uBOKokcbs/LMYvrF+YhE57oDYfqOxceh1/6nhRfN5digi5Li5dEMeo9SPelOk4G
         qOnh9zsYfCEB2cy7JBknFth9DyQK6bc1oaRQ/qFxSvNkdDa+hz4FpPng7iw/3iZIQ8IP
         70cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n2vGYK44AUmiHPqV1mudOtym+BRnlJBLZRp8SzeWKLM=;
        b=uHYyo4iM96v6Zhkux82oIJlvKsTyQeFOjtpuZ6bnyj7O1dee/kajbDZjNIStear0xF
         5dssdnS3KR3cKsXtxFroS1SSrZrCbZKmzYW3RraQ0ch1hDeIxJpQ5Qe0GKYC1/MXn5wg
         Jq3OznEkrVtffKjkyo0huziRRlk3vBD4xFasQMeD74xSJwk5S6vyXSfIkr62F+GrpdBo
         JrQQFyyqPL0q5E2gsSNUAw1estZOFbu4Ulb4bQaXeJm7lFnddMgpI31S5EffvkHIxwi1
         HhSUOK8fYp6wAAgEdRO4HqmCkAFIP9S9uc6+zR+xTgnm5zyQ6WVFhK/2fXb1PwRSk13X
         8Lbw==
X-Gm-Message-State: AJcUukdbc+8t0WX/zHjUZvXgvXhM8+ScoSNuE7r96NARNvZLChnUesnA
        ZoCx+fqU91r/f9rhQiLHIcMsH+14
X-Google-Smtp-Source: ALg8bN54Qs4kkFx+4ELHaEGWu/DXSuI4cA7BBi0ek/iSL8YTyFhtiI1BKXfhDvjZDTdZfHUyBbEo+w==
X-Received: by 2002:a62:4714:: with SMTP id u20mr26461539pfa.144.1547491215621;
        Mon, 14 Jan 2019 10:40:15 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id i193sm3589732pgc.22.2019.01.14.10.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 10:40:14 -0800 (PST)
Date:   Mon, 14 Jan 2019 10:40:12 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kim Phillips <kim@kimphillips.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics - add PNP IDs for Dell XPS models to
 forcepad
Message-ID: <20190114184012.GC117329@dtor-ws>
References: <20190111205430.15371-1-kim@kimphillips.com>
 <20190112014004.GA122403@dtor-ws>
 <22e2d619-0622-1816-2057-c9005288b46b@kimphillips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22e2d619-0622-1816-2057-c9005288b46b@kimphillips.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 04:04:36PM -0600, Kim Phillips wrote:
> On 1/11/19 7:40 PM, Dmitry Torokhov wrote:
> > Hi Kim,
> 
> Hi Dmitry,
> 
> > On Fri, Jan 11, 2019 at 02:54:30PM -0600, Kim Phillips wrote:
> >> This patch is the result of seeing this message:
> >>
> >> psmouse serio1: synaptics: Your touchpad (PNP: DLL087c PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
> >>
> >> If I set psmouse.synaptics_intertouch=1, or add the PNP ID to
> >> smbus_pnp_ids, the touchpad continues to work, and the above message
> >> goes away, but we now get:
> >>
> >> psmouse serio1: synaptics: Trying to set up SMBus access
> >> psmouse serio1: synaptics: SMbus companion is not ready yet
> >>
> >> With this patch applied, i.e., the PNP IDs are added to the forcepad
> >> array, the touchpad continues to work and all of the above messages
> >> disappear.
> > 
> > Are you sure the touchpad in XPSes is a forcepad (i.e. it does not have
> > physical button underneath it)? As far as I know there were only couple
> > of HP laptops with forcepads and when switching to RMI mode forcepads
> > need F21 handler that we do not currently have in the kernel.
> 
> I see, no, I'm not sure, but assuming you're right, the IDs 
> should be added to the smbus array instead, after fixing 
> the SMbus "companion not ready" problem?  Pointers for that and 
> the below interrupts when touchpad idle after resume, welcome.
> 
> Also, the link to get the RMI4 spec in
> Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
> is broken.  Any pointers for that also appreciated.

OK, sorting it all out some more:

- because we do not have support for F21 necessary for forcepads adding
  APIC ID to forcepad list actuallty disables SMbus companion mode, that
  is why you no longer see "companion not ready" messages vs. setting
  psmouse.synaptics_intertouch=1 module parameter.

- this does not really matter as your touchpad ends up being driven by
  i2c-hid and hid-multitouch drivers, and that is how we wait it to
  work, as we do not want to deviate from behavior on Windows since OEM
  tested it (the device and firmware) in tha configuration.

- we need to figure out issue with interrupts on resume, maybe Benjamin
  have seen it?

Thanks.

-- 
Dmitry
