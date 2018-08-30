Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D14AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53EE2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwVDqgBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53EE2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeH3L2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:28:49 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40169 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeH3L2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:28:49 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so1349781ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 00:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HhZRZLBqUtR72SVwlGDAy2051VZ0r+GV5CeroXAFpb4=;
        b=AwVDqgBu9nSDvEUUIKaU3GdzxM58vVHBYQ0APt7bwGawR4P8LplbPnaSnT/nAXUADI
         +yCBOY48Hypaima30bzHxqEGTM51WQGHv6KXtpjdWlECAQ43mgORxF10gqoiOi8hP8pj
         elGC21XZKZ+NWaSG3BTAshcFt6pghPm/mExsBtFmGFrfyPGldPn9sWyEQ2Zn9fv1LC5r
         o+iSFgMRByoAQxbCO8mCHz/NvTyJ4mLDN7dYAbtYou1SU4lvUAjeXsZT+doDtf5aYzX8
         wGhrGjAgax1vcL3/ljrkmLPEkUphx6ZZA0JRXmQqziz6Puj+CJsMj+W6A9mQlh1yHJxh
         gz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhZRZLBqUtR72SVwlGDAy2051VZ0r+GV5CeroXAFpb4=;
        b=tYk4sUMLjFdtvmA19YmLoD3kQfYThdqjB43GdtYlRMAKg8UTNllLJHKPWifSMS8O1s
         wmGCJVSEGI5QooNWPqdg6x0/cAlV9mV4ymRkawXazsvr6Pr6ixRNbvU4X4iYHQ2d+B3u
         QnBE3AKO3pejfzs8WPdgB0t8fnyO9ydndy04Uj33RAduEJCo4LcQYueUVdDO1vAQPuQZ
         khJuXEYeruigNwp6FbKDf7IyUBsoZjyqqEi6aRYu46HmfxDGe3NXS0VeA6+CzFj+yJ2O
         r/voZoOyPBRfbCdyB/BrZ0D1RRbB8yE331g7W1GYRfUos/4VMMyn43xSrtnZquCOySJy
         a7uQ==
X-Gm-Message-State: APzg51CjLX8oiXHkYSmyF13MkPzXUPevq6iT9VrGNRk17JuqXvr2Az1t
        dFtqviQBBv2vgKsEnoGQWlIeJV+UTo+2o5+ndew=
X-Google-Smtp-Source: ANB0Vdbl+mq+vFWN5cyqLAhotlBWoJTlzJWSWKOyfzW3kwlKzzkER4ANULU+WKDOnHklXBVkNKFjAdjaHVZZTbevG30=
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr1175628itc.68.1535614080970;
 Thu, 30 Aug 2018 00:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1808290829360.2280@hadrien>
In-Reply-To: <alpine.DEB.2.21.1808290829360.2280@hadrien>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Thu, 30 Aug 2018 15:27:50 +0800
Message-ID: <CADvbK_dncNrifNR-r39K83V=u19CWj+zkrgDno8-C_C7FACFtQ@mail.gmail.com>
Subject: Re: net/sctp/socket.c:2681:6-11: ERROR: invalid reference to the
 index variable of the iterator on line 2661 (fwd)
To:     julia.lawall@lip6.fr
Cc:     LKML <linux-kernel@vger.kernel.org>, kbuild-all@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 11:32 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> Hello,
>
> Are the ifs starting on lines 2655 and 2680 mutually exclusive?  If so,
> perhaps add an else.  If not, and if the trans on line 2681 can come from
> the trans initialized by the loop on line 2661, then there is a problem.
You're right, I will send a fix to add a local trans for
transport_addr_list traversing.
Thanks.

>
> julia
>
> ---------- Forwarded message ----------
> Date: Wed, 29 Aug 2018 22:02:39 +0800
> From: kbuild test robot <lkp@intel.com>
> To: kbuild@01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: net/sctp/socket.c:2681:6-11: ERROR: invalid reference to the index
>     variable of the iterator on line 2661
>
> CC: kbuild-all@01.org
> CC: linux-kernel@vger.kernel.org
> TO: Xin Long <lucien.xin@gmail.com>
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3f16503b7d2274ac8cbab11163047ac0b4c66cfe
> commit: 0b0dce7a36fb9f1a9dd8245ea82d3a268c6943fe sctp: add spp_ipv6_flowlabel and spp_dscp for sctp_paddrparams
> date:   8 weeks ago
> :::::: branch date: 15 hours ago
> :::::: commit date: 8 weeks ago
>
> >> net/sctp/socket.c:2681:6-11: ERROR: invalid reference to the index variable of the iterator on line 2661
>
> # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0b0dce7a36fb9f1a9dd8245ea82d3a268c6943fe
> git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git remote update linus
> git checkout 0b0dce7a36fb9f1a9dd8245ea82d3a268c6943fe
> vim +2681 net/sctp/socket.c
>
> ^1da177e4 Linus Torvalds          2005-04-16  2378
> ^1da177e4 Linus Torvalds          2005-04-16  2379  /* 7.1.13 Peer Address Parameters (SCTP_PEER_ADDR_PARAMS)
> ^1da177e4 Linus Torvalds          2005-04-16  2380   *
> ^1da177e4 Linus Torvalds          2005-04-16  2381   * Applications can enable or disable heartbeats for any peer address of
> ^1da177e4 Linus Torvalds          2005-04-16  2382   * an association, modify an address's heartbeat interval, force a
> ^1da177e4 Linus Torvalds          2005-04-16  2383   * heartbeat to be sent immediately, and adjust the address's maximum
> ^1da177e4 Linus Torvalds          2005-04-16  2384   * number of retransmissions sent before an address is considered
> ^1da177e4 Linus Torvalds          2005-04-16  2385   * unreachable.  The following structure is used to access and modify an
> ^1da177e4 Linus Torvalds          2005-04-16  2386   * address's parameters:
> ^1da177e4 Linus Torvalds          2005-04-16  2387   *
> ^1da177e4 Linus Torvalds          2005-04-16  2388   *  struct sctp_paddrparams {
> ^1da177e4 Linus Torvalds          2005-04-16  2389   *     sctp_assoc_t            spp_assoc_id;
> ^1da177e4 Linus Torvalds          2005-04-16  2390   *     struct sockaddr_storage spp_address;
> ^1da177e4 Linus Torvalds          2005-04-16  2391   *     uint32_t                spp_hbinterval;
> ^1da177e4 Linus Torvalds          2005-04-16  2392   *     uint16_t                spp_pathmaxrxt;
> 52ccb8e90 Frank Filz              2005-12-22  2393   *     uint32_t                spp_pathmtu;
> 52ccb8e90 Frank Filz              2005-12-22  2394   *     uint32_t                spp_sackdelay;
> 52ccb8e90 Frank Filz              2005-12-22  2395   *     uint32_t                spp_flags;
> 0b0dce7a3 Xin Long                2018-07-02  2396   *     uint32_t                spp_ipv6_flowlabel;
> 0b0dce7a3 Xin Long                2018-07-02  2397   *     uint8_t                 spp_dscp;
> ^1da177e4 Linus Torvalds          2005-04-16  2398   * };
> ^1da177e4 Linus Torvalds          2005-04-16  2399   *
> 52ccb8e90 Frank Filz              2005-12-22  2400   *   spp_assoc_id    - (one-to-many style socket) This is filled in the
> 52ccb8e90 Frank Filz              2005-12-22  2401   *                     application, and identifies the association for
> 52ccb8e90 Frank Filz              2005-12-22  2402   *                     this query.
> ^1da177e4 Linus Torvalds          2005-04-16  2403   *   spp_address     - This specifies which address is of interest.
> ^1da177e4 Linus Torvalds          2005-04-16  2404   *   spp_hbinterval  - This contains the value of the heartbeat interval,
> 52ccb8e90 Frank Filz              2005-12-22  2405   *                     in milliseconds.  If a  value of zero
> 52ccb8e90 Frank Filz              2005-12-22  2406   *                     is present in this field then no changes are to
> 52ccb8e90 Frank Filz              2005-12-22  2407   *                     be made to this parameter.
> ^1da177e4 Linus Torvalds          2005-04-16  2408   *   spp_pathmaxrxt  - This contains the maximum number of
> ^1da177e4 Linus Torvalds          2005-04-16  2409   *                     retransmissions before this address shall be
> 52ccb8e90 Frank Filz              2005-12-22  2410   *                     considered unreachable. If a  value of zero
> 52ccb8e90 Frank Filz              2005-12-22  2411   *                     is present in this field then no changes are to
> 52ccb8e90 Frank Filz              2005-12-22  2412   *                     be made to this parameter.
> 52ccb8e90 Frank Filz              2005-12-22  2413   *   spp_pathmtu     - When Path MTU discovery is disabled the value
> 52ccb8e90 Frank Filz              2005-12-22  2414   *                     specified here will be the "fixed" path mtu.
> 52ccb8e90 Frank Filz              2005-12-22  2415   *                     Note that if the spp_address field is empty
> 52ccb8e90 Frank Filz              2005-12-22  2416   *                     then all associations on this address will
> 52ccb8e90 Frank Filz              2005-12-22  2417   *                     have this fixed path mtu set upon them.
> 52ccb8e90 Frank Filz              2005-12-22  2418   *
> 52ccb8e90 Frank Filz              2005-12-22  2419   *   spp_sackdelay   - When delayed sack is enabled, this value specifies
> 52ccb8e90 Frank Filz              2005-12-22  2420   *                     the number of milliseconds that sacks will be delayed
> 52ccb8e90 Frank Filz              2005-12-22  2421   *                     for. This value will apply to all addresses of an
> 52ccb8e90 Frank Filz              2005-12-22  2422   *                     association if the spp_address field is empty. Note
> 52ccb8e90 Frank Filz              2005-12-22  2423   *                     also, that if delayed sack is enabled and this
> 52ccb8e90 Frank Filz              2005-12-22  2424   *                     value is set to 0, no change is made to the last
> 52ccb8e90 Frank Filz              2005-12-22  2425   *                     recorded delayed sack timer value.
> 52ccb8e90 Frank Filz              2005-12-22  2426   *
> 52ccb8e90 Frank Filz              2005-12-22  2427   *   spp_flags       - These flags are used to control various features
> 52ccb8e90 Frank Filz              2005-12-22  2428   *                     on an association. The flag field may contain
> 52ccb8e90 Frank Filz              2005-12-22  2429   *                     zero or more of the following options.
> 52ccb8e90 Frank Filz              2005-12-22  2430   *
> 52ccb8e90 Frank Filz              2005-12-22  2431   *                     SPP_HB_ENABLE  - Enable heartbeats on the
> 52ccb8e90 Frank Filz              2005-12-22  2432   *                     specified address. Note that if the address
> 52ccb8e90 Frank Filz              2005-12-22  2433   *                     field is empty all addresses for the association
> 52ccb8e90 Frank Filz              2005-12-22  2434   *                     have heartbeats enabled upon them.
> 52ccb8e90 Frank Filz              2005-12-22  2435   *
> 52ccb8e90 Frank Filz              2005-12-22  2436   *                     SPP_HB_DISABLE - Disable heartbeats on the
> 52ccb8e90 Frank Filz              2005-12-22  2437   *                     speicifed address. Note that if the address
> 52ccb8e90 Frank Filz              2005-12-22  2438   *                     field is empty all addresses for the association
> 52ccb8e90 Frank Filz              2005-12-22  2439   *                     will have their heartbeats disabled. Note also
> 52ccb8e90 Frank Filz              2005-12-22  2440   *                     that SPP_HB_ENABLE and SPP_HB_DISABLE are
> 52ccb8e90 Frank Filz              2005-12-22  2441   *                     mutually exclusive, only one of these two should
> 52ccb8e90 Frank Filz              2005-12-22  2442   *                     be specified. Enabling both fields will have
> 52ccb8e90 Frank Filz              2005-12-22  2443   *                     undetermined results.
> 52ccb8e90 Frank Filz              2005-12-22  2444   *
> 52ccb8e90 Frank Filz              2005-12-22  2445   *                     SPP_HB_DEMAND - Request a user initiated heartbeat
> 52ccb8e90 Frank Filz              2005-12-22  2446   *                     to be made immediately.
> 52ccb8e90 Frank Filz              2005-12-22  2447   *
> bdf3092af Vlad Yasevich           2007-03-23  2448   *                     SPP_HB_TIME_IS_ZERO - Specify's that the time for
> bdf3092af Vlad Yasevich           2007-03-23  2449   *                     heartbeat delayis to be set to the value of 0
> bdf3092af Vlad Yasevich           2007-03-23  2450   *                     milliseconds.
> bdf3092af Vlad Yasevich           2007-03-23  2451   *
> 52ccb8e90 Frank Filz              2005-12-22  2452   *                     SPP_PMTUD_ENABLE - This field will enable PMTU
> 52ccb8e90 Frank Filz              2005-12-22  2453   *                     discovery upon the specified address. Note that
> 52ccb8e90 Frank Filz              2005-12-22  2454   *                     if the address feild is empty then all addresses
> 52ccb8e90 Frank Filz              2005-12-22  2455   *                     on the association are effected.
> 52ccb8e90 Frank Filz              2005-12-22  2456   *
> 52ccb8e90 Frank Filz              2005-12-22  2457   *                     SPP_PMTUD_DISABLE - This field will disable PMTU
> 52ccb8e90 Frank Filz              2005-12-22  2458   *                     discovery upon the specified address. Note that
> 52ccb8e90 Frank Filz              2005-12-22  2459   *                     if the address feild is empty then all addresses
> 52ccb8e90 Frank Filz              2005-12-22  2460   *                     on the association are effected. Not also that
> 52ccb8e90 Frank Filz              2005-12-22  2461   *                     SPP_PMTUD_ENABLE and SPP_PMTUD_DISABLE are mutually
> 52ccb8e90 Frank Filz              2005-12-22  2462   *                     exclusive. Enabling both will have undetermined
> 52ccb8e90 Frank Filz              2005-12-22  2463   *                     results.
> 52ccb8e90 Frank Filz              2005-12-22  2464   *
> 52ccb8e90 Frank Filz              2005-12-22  2465   *                     SPP_SACKDELAY_ENABLE - Setting this flag turns
> 52ccb8e90 Frank Filz              2005-12-22  2466   *                     on delayed sack. The time specified in spp_sackdelay
> 52ccb8e90 Frank Filz              2005-12-22  2467   *                     is used to specify the sack delay for this address. Note
> 52ccb8e90 Frank Filz              2005-12-22  2468   *                     that if spp_address is empty then all addresses will
> 52ccb8e90 Frank Filz              2005-12-22  2469   *                     enable delayed sack and take on the sack delay
> 52ccb8e90 Frank Filz              2005-12-22  2470   *                     value specified in spp_sackdelay.
> 52ccb8e90 Frank Filz              2005-12-22  2471   *                     SPP_SACKDELAY_DISABLE - Setting this flag turns
> 52ccb8e90 Frank Filz              2005-12-22  2472   *                     off delayed sack. If the spp_address field is blank then
> 52ccb8e90 Frank Filz              2005-12-22  2473   *                     delayed sack is disabled for the entire association. Note
> 52ccb8e90 Frank Filz              2005-12-22  2474   *                     also that this field is mutually exclusive to
> 52ccb8e90 Frank Filz              2005-12-22  2475   *                     SPP_SACKDELAY_ENABLE, setting both will have undefined
> 52ccb8e90 Frank Filz              2005-12-22  2476   *                     results.
> 0b0dce7a3 Xin Long                2018-07-02  2477   *
> 0b0dce7a3 Xin Long                2018-07-02  2478   *                     SPP_IPV6_FLOWLABEL:  Setting this flag enables the
> 0b0dce7a3 Xin Long                2018-07-02  2479   *                     setting of the IPV6 flow label value.  The value is
> 0b0dce7a3 Xin Long                2018-07-02  2480   *                     contained in the spp_ipv6_flowlabel field.
> 0b0dce7a3 Xin Long                2018-07-02  2481   *                     Upon retrieval, this flag will be set to indicate that
> 0b0dce7a3 Xin Long                2018-07-02  2482   *                     the spp_ipv6_flowlabel field has a valid value returned.
> 0b0dce7a3 Xin Long                2018-07-02  2483   *                     If a specific destination address is set (in the
> 0b0dce7a3 Xin Long                2018-07-02  2484   *                     spp_address field), then the value returned is that of
> 0b0dce7a3 Xin Long                2018-07-02  2485   *                     the address.  If just an association is specified (and
> 0b0dce7a3 Xin Long                2018-07-02  2486   *                     no address), then the association's default flow label
> 0b0dce7a3 Xin Long                2018-07-02  2487   *                     is returned.  If neither an association nor a destination
> 0b0dce7a3 Xin Long                2018-07-02  2488   *                     is specified, then the socket's default flow label is
> 0b0dce7a3 Xin Long                2018-07-02  2489   *                     returned.  For non-IPv6 sockets, this flag will be left
> 0b0dce7a3 Xin Long                2018-07-02  2490   *                     cleared.
> 0b0dce7a3 Xin Long                2018-07-02  2491   *
> 0b0dce7a3 Xin Long                2018-07-02  2492   *                     SPP_DSCP:  Setting this flag enables the setting of the
> 0b0dce7a3 Xin Long                2018-07-02  2493   *                     Differentiated Services Code Point (DSCP) value
> 0b0dce7a3 Xin Long                2018-07-02  2494   *                     associated with either the association or a specific
> 0b0dce7a3 Xin Long                2018-07-02  2495   *                     address.  The value is obtained in the spp_dscp field.
> 0b0dce7a3 Xin Long                2018-07-02  2496   *                     Upon retrieval, this flag will be set to indicate that
> 0b0dce7a3 Xin Long                2018-07-02  2497   *                     the spp_dscp field has a valid value returned.  If a
> 0b0dce7a3 Xin Long                2018-07-02  2498   *                     specific destination address is set when called (in the
> 0b0dce7a3 Xin Long                2018-07-02  2499   *                     spp_address field), then that specific destination
> 0b0dce7a3 Xin Long                2018-07-02  2500   *                     address's DSCP value is returned.  If just an association
> 0b0dce7a3 Xin Long                2018-07-02  2501   *                     is specified, then the association's default DSCP is
> 0b0dce7a3 Xin Long                2018-07-02  2502   *                     returned.  If neither an association nor a destination is
> 0b0dce7a3 Xin Long                2018-07-02  2503   *                     specified, then the socket's default DSCP is returned.
> 0b0dce7a3 Xin Long                2018-07-02  2504   *
> 0b0dce7a3 Xin Long                2018-07-02  2505   *   spp_ipv6_flowlabel
> 0b0dce7a3 Xin Long                2018-07-02  2506   *                   - This field is used in conjunction with the
> 0b0dce7a3 Xin Long                2018-07-02  2507   *                     SPP_IPV6_FLOWLABEL flag and contains the IPv6 flow label.
> 0b0dce7a3 Xin Long                2018-07-02  2508   *                     The 20 least significant bits are used for the flow
> 0b0dce7a3 Xin Long                2018-07-02  2509   *                     label.  This setting has precedence over any IPv6-layer
> 0b0dce7a3 Xin Long                2018-07-02  2510   *                     setting.
> 0b0dce7a3 Xin Long                2018-07-02  2511   *
> 0b0dce7a3 Xin Long                2018-07-02  2512   *   spp_dscp        - This field is used in conjunction with the SPP_DSCP flag
> 0b0dce7a3 Xin Long                2018-07-02  2513   *                     and contains the DSCP.  The 6 most significant bits are
> 0b0dce7a3 Xin Long                2018-07-02  2514   *                     used for the DSCP.  This setting has precedence over any
> 0b0dce7a3 Xin Long                2018-07-02  2515   *                     IPv4- or IPv6- layer setting.
> 52ccb8e90 Frank Filz              2005-12-22  2516   */
> 161643660 Adrian Bunk             2006-09-18  2517  static int sctp_apply_peer_addr_params(struct sctp_paddrparams *params,
> 52ccb8e90 Frank Filz              2005-12-22  2518                                     struct sctp_transport   *trans,
> 52ccb8e90 Frank Filz              2005-12-22  2519                                     struct sctp_association *asoc,
> 52ccb8e90 Frank Filz              2005-12-22  2520                                     struct sctp_sock        *sp,
> 52ccb8e90 Frank Filz              2005-12-22  2521                                     int                      hb_change,
> 52ccb8e90 Frank Filz              2005-12-22  2522                                     int                      pmtud_change,
> 52ccb8e90 Frank Filz              2005-12-22  2523                                     int                      sackdelay_change)
> 52ccb8e90 Frank Filz              2005-12-22  2524  {
> 52ccb8e90 Frank Filz              2005-12-22  2525      int error;
> 52ccb8e90 Frank Filz              2005-12-22  2526
> 52ccb8e90 Frank Filz              2005-12-22  2527      if (params->spp_flags & SPP_HB_DEMAND && trans) {
> 55e26eb95 Eric W. Biederman       2012-08-07  2528              struct net *net = sock_net(trans->asoc->base.sk);
> 55e26eb95 Eric W. Biederman       2012-08-07  2529
> 55e26eb95 Eric W. Biederman       2012-08-07  2530              error = sctp_primitive_REQUESTHEARTBEAT(net, trans->asoc, trans);
> 52ccb8e90 Frank Filz              2005-12-22  2531              if (error)
> 52ccb8e90 Frank Filz              2005-12-22  2532                      return error;
> 52ccb8e90 Frank Filz              2005-12-22  2533      }
> 52ccb8e90 Frank Filz              2005-12-22  2534
> bdf3092af Vlad Yasevich           2007-03-23  2535      /* Note that unless the spp_flag is set to SPP_HB_ENABLE the value of
> bdf3092af Vlad Yasevich           2007-03-23  2536       * this field is ignored.  Note also that a value of zero indicates
> bdf3092af Vlad Yasevich           2007-03-23  2537       * the current setting should be left unchanged.
> bdf3092af Vlad Yasevich           2007-03-23  2538       */
> bdf3092af Vlad Yasevich           2007-03-23  2539      if (params->spp_flags & SPP_HB_ENABLE) {
> bdf3092af Vlad Yasevich           2007-03-23  2540
> bdf3092af Vlad Yasevich           2007-03-23  2541              /* Re-zero the interval if the SPP_HB_TIME_IS_ZERO is
> bdf3092af Vlad Yasevich           2007-03-23  2542               * set.  This lets us use 0 value when this flag
> bdf3092af Vlad Yasevich           2007-03-23  2543               * is set.
> bdf3092af Vlad Yasevich           2007-03-23  2544               */
> bdf3092af Vlad Yasevich           2007-03-23  2545              if (params->spp_flags & SPP_HB_TIME_IS_ZERO)
> bdf3092af Vlad Yasevich           2007-03-23  2546                      params->spp_hbinterval = 0;
> bdf3092af Vlad Yasevich           2007-03-23  2547
> bdf3092af Vlad Yasevich           2007-03-23  2548              if (params->spp_hbinterval ||
> bdf3092af Vlad Yasevich           2007-03-23  2549                  (params->spp_flags & SPP_HB_TIME_IS_ZERO)) {
> 52ccb8e90 Frank Filz              2005-12-22  2550                      if (trans) {
> bdf3092af Vlad Yasevich           2007-03-23  2551                              trans->hbinterval =
> bdf3092af Vlad Yasevich           2007-03-23  2552                                  msecs_to_jiffies(params->spp_hbinterval);
> 52ccb8e90 Frank Filz              2005-12-22  2553                      } else if (asoc) {
> bdf3092af Vlad Yasevich           2007-03-23  2554                              asoc->hbinterval =
> bdf3092af Vlad Yasevich           2007-03-23  2555                                  msecs_to_jiffies(params->spp_hbinterval);
> 52ccb8e90 Frank Filz              2005-12-22  2556                      } else {
> 52ccb8e90 Frank Filz              2005-12-22  2557                              sp->hbinterval = params->spp_hbinterval;
> 52ccb8e90 Frank Filz              2005-12-22  2558                      }
> 52ccb8e90 Frank Filz              2005-12-22  2559              }
> bdf3092af Vlad Yasevich           2007-03-23  2560      }
> 52ccb8e90 Frank Filz              2005-12-22  2561
> 52ccb8e90 Frank Filz              2005-12-22  2562      if (hb_change) {
> 52ccb8e90 Frank Filz              2005-12-22  2563              if (trans) {
> 52ccb8e90 Frank Filz              2005-12-22  2564                      trans->param_flags =
> 52ccb8e90 Frank Filz              2005-12-22  2565                              (trans->param_flags & ~SPP_HB) | hb_change;
> 52ccb8e90 Frank Filz              2005-12-22  2566              } else if (asoc) {
> 52ccb8e90 Frank Filz              2005-12-22  2567                      asoc->param_flags =
> 52ccb8e90 Frank Filz              2005-12-22  2568                              (asoc->param_flags & ~SPP_HB) | hb_change;
> 52ccb8e90 Frank Filz              2005-12-22  2569              } else {
> 52ccb8e90 Frank Filz              2005-12-22  2570                      sp->param_flags =
> 52ccb8e90 Frank Filz              2005-12-22  2571                              (sp->param_flags & ~SPP_HB) | hb_change;
> 52ccb8e90 Frank Filz              2005-12-22  2572              }
> 52ccb8e90 Frank Filz              2005-12-22  2573      }
> 52ccb8e90 Frank Filz              2005-12-22  2574
> bdf3092af Vlad Yasevich           2007-03-23  2575      /* When Path MTU discovery is disabled the value specified here will
> bdf3092af Vlad Yasevich           2007-03-23  2576       * be the "fixed" path mtu (i.e. the value of the spp_flags field must
> bdf3092af Vlad Yasevich           2007-03-23  2577       * include the flag SPP_PMTUD_DISABLE for this field to have any
> bdf3092af Vlad Yasevich           2007-03-23  2578       * effect).
> bdf3092af Vlad Yasevich           2007-03-23  2579       */
> bdf3092af Vlad Yasevich           2007-03-23  2580      if ((params->spp_flags & SPP_PMTUD_DISABLE) && params->spp_pathmtu) {
> 52ccb8e90 Frank Filz              2005-12-22  2581              if (trans) {
> 52ccb8e90 Frank Filz              2005-12-22  2582                      trans->pathmtu = params->spp_pathmtu;
> 3ebfdf082 Xin Long                2017-04-04  2583                      sctp_assoc_sync_pmtu(asoc);
> 52ccb8e90 Frank Filz              2005-12-22  2584              } else if (asoc) {
> c4b2893da Marcelo Ricardo Leitner 2018-04-26  2585                      sctp_assoc_set_pmtu(asoc, params->spp_pathmtu);
> 52ccb8e90 Frank Filz              2005-12-22  2586              } else {
> 52ccb8e90 Frank Filz              2005-12-22  2587                      sp->pathmtu = params->spp_pathmtu;
> 52ccb8e90 Frank Filz              2005-12-22  2588              }
> 52ccb8e90 Frank Filz              2005-12-22  2589      }
> 52ccb8e90 Frank Filz              2005-12-22  2590
> 52ccb8e90 Frank Filz              2005-12-22  2591      if (pmtud_change) {
> 52ccb8e90 Frank Filz              2005-12-22  2592              if (trans) {
> 52ccb8e90 Frank Filz              2005-12-22  2593                      int update = (trans->param_flags & SPP_PMTUD_DISABLE) &&
> 52ccb8e90 Frank Filz              2005-12-22  2594                              (params->spp_flags & SPP_PMTUD_ENABLE);
> 52ccb8e90 Frank Filz              2005-12-22  2595                      trans->param_flags =
> 52ccb8e90 Frank Filz              2005-12-22  2596                              (trans->param_flags & ~SPP_PMTUD) | pmtud_change;
> 52ccb8e90 Frank Filz              2005-12-22  2597                      if (update) {
> 9914ae3ca Vlad Yasevich           2011-04-26  2598                              sctp_transport_pmtu(trans, sctp_opt2sk(sp));
> 3ebfdf082 Xin Long                2017-04-04  2599                              sctp_assoc_sync_pmtu(asoc);
> 52ccb8e90 Frank Filz              2005-12-22  2600                      }
> 52ccb8e90 Frank Filz              2005-12-22  2601              } else if (asoc) {
> 52ccb8e90 Frank Filz              2005-12-22  2602                      asoc->param_flags =
> 52ccb8e90 Frank Filz              2005-12-22  2603                              (asoc->param_flags & ~SPP_PMTUD) | pmtud_change;
> 52ccb8e90 Frank Filz              2005-12-22  2604              } else {
> 52ccb8e90 Frank Filz              2005-12-22  2605                      sp->param_flags =
> 52ccb8e90 Frank Filz              2005-12-22  2606                              (sp->param_flags & ~SPP_PMTUD) | pmtud_change;
> 52ccb8e90 Frank Filz              2005-12-22  2607              }
> 52ccb8e90 Frank Filz              2005-12-22  2608      }
> 52ccb8e90 Frank Filz              2005-12-22  2609
> bdf3092af Vlad Yasevich           2007-03-23  2610      /* Note that unless the spp_flag is set to SPP_SACKDELAY_ENABLE the
> bdf3092af Vlad Yasevich           2007-03-23  2611       * value of this field is ignored.  Note also that a value of zero
> bdf3092af Vlad Yasevich           2007-03-23  2612       * indicates the current setting should be left unchanged.
> bdf3092af Vlad Yasevich           2007-03-23  2613       */
> bdf3092af Vlad Yasevich           2007-03-23  2614      if ((params->spp_flags & SPP_SACKDELAY_ENABLE) && params->spp_sackdelay) {
> 52ccb8e90 Frank Filz              2005-12-22  2615              if (trans) {
> 52ccb8e90 Frank Filz              2005-12-22  2616                      trans->sackdelay =
> 52ccb8e90 Frank Filz              2005-12-22  2617                              msecs_to_jiffies(params->spp_sackdelay);
> 52ccb8e90 Frank Filz              2005-12-22  2618              } else if (asoc) {
> 52ccb8e90 Frank Filz              2005-12-22  2619                      asoc->sackdelay =
> 52ccb8e90 Frank Filz              2005-12-22  2620                              msecs_to_jiffies(params->spp_sackdelay);
> 52ccb8e90 Frank Filz              2005-12-22  2621              } else {
> 52ccb8e90 Frank Filz              2005-12-22  2622                      sp->sackdelay = params->spp_sackdelay;
> 52ccb8e90 Frank Filz              2005-12-22  2623              }
> 52ccb8e90 Frank Filz              2005-12-22  2624      }
> 52ccb8e90 Frank Filz              2005-12-22  2625
> 52ccb8e90 Frank Filz              2005-12-22  2626      if (sackdelay_change) {
> 52ccb8e90 Frank Filz              2005-12-22  2627              if (trans) {
> 52ccb8e90 Frank Filz              2005-12-22  2628                      trans->param_flags =
> 52ccb8e90 Frank Filz              2005-12-22  2629                              (trans->param_flags & ~SPP_SACKDELAY) |
> 52ccb8e90 Frank Filz              2005-12-22  2630                              sackdelay_change;
> 52ccb8e90 Frank Filz              2005-12-22  2631              } else if (asoc) {
> 52ccb8e90 Frank Filz              2005-12-22  2632                      asoc->param_flags =
> 52ccb8e90 Frank Filz              2005-12-22  2633                              (asoc->param_flags & ~SPP_SACKDELAY) |
> 52ccb8e90 Frank Filz              2005-12-22  2634                              sackdelay_change;
> 52ccb8e90 Frank Filz              2005-12-22  2635              } else {
> 52ccb8e90 Frank Filz              2005-12-22  2636                      sp->param_flags =
> 52ccb8e90 Frank Filz              2005-12-22  2637                              (sp->param_flags & ~SPP_SACKDELAY) |
> 52ccb8e90 Frank Filz              2005-12-22  2638                              sackdelay_change;
> 52ccb8e90 Frank Filz              2005-12-22  2639              }
> 52ccb8e90 Frank Filz              2005-12-22  2640      }
> 52ccb8e90 Frank Filz              2005-12-22  2641
> 37051f738 Andrei Pelinescu-Onciul 2009-11-23  2642      /* Note that a value of zero indicates the current setting should be
> 37051f738 Andrei Pelinescu-Onciul 2009-11-23  2643         left unchanged.
> bdf3092af Vlad Yasevich           2007-03-23  2644       */
> 37051f738 Andrei Pelinescu-Onciul 2009-11-23  2645      if (params->spp_pathmaxrxt) {
> 52ccb8e90 Frank Filz              2005-12-22  2646              if (trans) {
> 52ccb8e90 Frank Filz              2005-12-22  2647                      trans->pathmaxrxt = params->spp_pathmaxrxt;
> 52ccb8e90 Frank Filz              2005-12-22  2648              } else if (asoc) {
> 52ccb8e90 Frank Filz              2005-12-22  2649                      asoc->pathmaxrxt = params->spp_pathmaxrxt;
> 52ccb8e90 Frank Filz              2005-12-22  2650              } else {
> 52ccb8e90 Frank Filz              2005-12-22  2651                      sp->pathmaxrxt = params->spp_pathmaxrxt;
> 52ccb8e90 Frank Filz              2005-12-22  2652              }
> 52ccb8e90 Frank Filz              2005-12-22  2653      }
> 52ccb8e90 Frank Filz              2005-12-22  2654
> 0b0dce7a3 Xin Long                2018-07-02  2655      if (params->spp_flags & SPP_IPV6_FLOWLABEL) {
> 0b0dce7a3 Xin Long                2018-07-02  2656              if (trans && trans->ipaddr.sa.sa_family == AF_INET6) {
> 0b0dce7a3 Xin Long                2018-07-02  2657                      trans->flowlabel = params->spp_ipv6_flowlabel &
> 0b0dce7a3 Xin Long                2018-07-02  2658                                         SCTP_FLOWLABEL_VAL_MASK;
> 0b0dce7a3 Xin Long                2018-07-02  2659                      trans->flowlabel |= SCTP_FLOWLABEL_SET_MASK;
> 0b0dce7a3 Xin Long                2018-07-02  2660              } else if (asoc) {
> 0b0dce7a3 Xin Long                2018-07-02 @2661                      list_for_each_entry(trans,
> 0b0dce7a3 Xin Long                2018-07-02  2662                                          &asoc->peer.transport_addr_list,
> 0b0dce7a3 Xin Long                2018-07-02  2663                                          transports) {
> 0b0dce7a3 Xin Long                2018-07-02  2664                              if (trans->ipaddr.sa.sa_family != AF_INET6)
> 0b0dce7a3 Xin Long                2018-07-02  2665                                      continue;
> 0b0dce7a3 Xin Long                2018-07-02  2666                              trans->flowlabel = params->spp_ipv6_flowlabel &
> 0b0dce7a3 Xin Long                2018-07-02  2667                                                 SCTP_FLOWLABEL_VAL_MASK;
> 0b0dce7a3 Xin Long                2018-07-02  2668                              trans->flowlabel |= SCTP_FLOWLABEL_SET_MASK;
> 0b0dce7a3 Xin Long                2018-07-02  2669                      }
> 0b0dce7a3 Xin Long                2018-07-02  2670                      asoc->flowlabel = params->spp_ipv6_flowlabel &
> 0b0dce7a3 Xin Long                2018-07-02  2671                                        SCTP_FLOWLABEL_VAL_MASK;
> 0b0dce7a3 Xin Long                2018-07-02  2672                      asoc->flowlabel |= SCTP_FLOWLABEL_SET_MASK;
> 0b0dce7a3 Xin Long                2018-07-02  2673              } else if (sctp_opt2sk(sp)->sk_family == AF_INET6) {
> 0b0dce7a3 Xin Long                2018-07-02  2674                      sp->flowlabel = params->spp_ipv6_flowlabel &
> 0b0dce7a3 Xin Long                2018-07-02  2675                                      SCTP_FLOWLABEL_VAL_MASK;
> 0b0dce7a3 Xin Long                2018-07-02  2676                      sp->flowlabel |= SCTP_FLOWLABEL_SET_MASK;
> 0b0dce7a3 Xin Long                2018-07-02  2677              }
> 0b0dce7a3 Xin Long                2018-07-02  2678      }
> 0b0dce7a3 Xin Long                2018-07-02  2679
> 0b0dce7a3 Xin Long                2018-07-02  2680      if (params->spp_flags & SPP_DSCP) {
> 0b0dce7a3 Xin Long                2018-07-02 @2681              if (trans) {
> 0b0dce7a3 Xin Long                2018-07-02  2682                      trans->dscp = params->spp_dscp & SCTP_DSCP_VAL_MASK;
> 0b0dce7a3 Xin Long                2018-07-02  2683                      trans->dscp |= SCTP_DSCP_SET_MASK;
> 0b0dce7a3 Xin Long                2018-07-02  2684              } else if (asoc) {
> 0b0dce7a3 Xin Long                2018-07-02  2685                      list_for_each_entry(trans,
> 0b0dce7a3 Xin Long                2018-07-02  2686                                          &asoc->peer.transport_addr_list,
> 0b0dce7a3 Xin Long                2018-07-02  2687                                          transports) {
> 0b0dce7a3 Xin Long                2018-07-02  2688                              trans->dscp = params->spp_dscp &
> 0b0dce7a3 Xin Long                2018-07-02  2689                                            SCTP_DSCP_VAL_MASK;
> 0b0dce7a3 Xin Long                2018-07-02  2690                              trans->dscp |= SCTP_DSCP_SET_MASK;
> 0b0dce7a3 Xin Long                2018-07-02  2691                      }
> 0b0dce7a3 Xin Long                2018-07-02  2692                      asoc->dscp = params->spp_dscp & SCTP_DSCP_VAL_MASK;
> 0b0dce7a3 Xin Long                2018-07-02  2693                      asoc->dscp |= SCTP_DSCP_SET_MASK;
> 0b0dce7a3 Xin Long                2018-07-02  2694              } else {
> 0b0dce7a3 Xin Long                2018-07-02  2695                      sp->dscp = params->spp_dscp & SCTP_DSCP_VAL_MASK;
> 0b0dce7a3 Xin Long                2018-07-02  2696                      sp->dscp |= SCTP_DSCP_SET_MASK;
> 0b0dce7a3 Xin Long                2018-07-02  2697              }
> 0b0dce7a3 Xin Long                2018-07-02  2698      }
> 0b0dce7a3 Xin Long                2018-07-02  2699
> 52ccb8e90 Frank Filz              2005-12-22  2700      return 0;
> 52ccb8e90 Frank Filz              2005-12-22  2701  }
> 52ccb8e90 Frank Filz              2005-12-22  2702
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
