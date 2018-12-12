Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48817C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2502084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544618483;
	bh=z+5LH1hCZx2l3l7IKXdlw+SBzMxwVl9tL66Zdr7NBBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=idO88sF/8hj/Rqf36Pm8OGKtGrPevdcIZqGrMgnsJjGM7nsY9CeLQ+ANgNOj8hOUI
	 4drckaeGITeev8COMvTe/kOSjSSHCz/K7i05W9Qz9SwL+gFpj9hQqtnbAlqIt7r3Lv
	 CDL3masVXiXpb5OMpTftCH09G6Np7X8XSR0KN/t4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2502084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeLLMlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:41:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:54132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbeLLMlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:41:21 -0500
Received: from quaco.ghostprotocols.net (unknown [177.159.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DF8F2084E;
        Wed, 12 Dec 2018 12:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544618480;
        bh=z+5LH1hCZx2l3l7IKXdlw+SBzMxwVl9tL66Zdr7NBBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qpUamkkc6nL+a43WFEspyWHrTrvA6HWvQUM0IbOSRigIUBl2hftUuY/k1xZgGxusR
         Tk/HSdOFmA0Jnp29D8A2XyGqwOxckHxw9dttZrQVf/5kxvwioENcvRtKDNDgJ7DzWK
         KAbNgKUj+tmoWa2seyUy9K77OFiYx8X1ZUpicxlg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 15F2A4042C; Wed, 12 Dec 2018 09:41:17 -0300 (-03)
Date:   Wed, 12 Dec 2018 09:41:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        "Herton R. Krzesinski" <herton@redhat.com>
Subject: Re: [PATCHv3 01/10] tools lib traceevent: Use LDFLAGS in the build
 commands
Message-ID: <20181212124116.GA21027@kernel.org>
References: <20181016150614.21260-1-jolsa@kernel.org>
 <20181016150614.21260-2-jolsa@kernel.org>
 <20181016112136.3a72a452@gandalf.local.home>
 <20181016154526.GC6631@krava>
 <20181017102341.53412998@gandalf.local.home>
 <20181116130158.GA30583@krava>
 <20181122093006.GD15953@krava>
 <20181128135641.GD31608@kernel.org>
 <20181212091214.GC17489@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212091214.GC17489@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 12, 2018 at 10:12:14AM +0100, Jiri Olsa escreveu:
> On Wed, Nov 28, 2018 at 10:56:41AM -0300, Arnaldo Carvalho de Melo wrote:
> > /opt/android-ndk-r12b/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/../lib/gcc/arm-linux-androideabi/4.9.x/../../../../arm-linux-androideabi/bin/ld: error: cannot find -lc
> > /opt/android-ndk-r12b/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/../lib/gcc/arm-linux-androideabi/4.9.x/../../../../arm-linux-androideabi/bin/ld: error: cannot find -ldl
> > collect2: error: ld returned 1 exit status
> > Makefile:196: recipe for target '/tmp/build/perf/plugin_jbd2.so' failed
> > make[3]: *** [/tmp/build/perf/plugin_jbd2.so] Error 1
> > Makefile.perf:669: recipe for target 'libtraceevent_plugins' failed
> > make[2]: *** [libtraceevent_plugins] Error 2
> > make[2]: *** Waiting for unfinished jobs....
> 
> SNIP
> 
> >    1    59.08 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
> >    2    68.75 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
> >    3    79.67 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
> >    4    48.69 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
> >    5    46.89 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0
> >    6    46.46 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
> >    7    38.46 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
> >    8    44.69 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
> >    9    41.88 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
> >   10    46.24 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
> >   11    22.22 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
> >   12    35.54 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
 
> ok, I shouldn't have taken out the CFLAGS,
> some build scripts depends on it already
 
> attaching v2

[acme@quaco arm]$ export PERF_TARBALL=http://192.168.124.1/perf/perf-4.20.0-rc3.tar.xz
[acme@quaco arm]$ dm android-ndk:{r12b,r15c}-arm
   1    29.58 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   2    37.19 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
[acme@quaco arm]$

Applied,

Thanks

- Arnaldo
