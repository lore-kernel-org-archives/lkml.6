Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2C476C07E80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C4520869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C4520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thebollingers.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753742AbeFKSuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:50:22 -0400
Received: from resqmta-po-09v.sys.comcast.net ([96.114.154.168]:52816 "EHLO
        resqmta-po-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750965AbeFKSuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:50:21 -0400
Received: from resomta-po-05v.sys.comcast.net ([96.114.154.229])
        by resqmta-po-09v.sys.comcast.net with ESMTP
        id SR5zfpCKXv8ZOSRtUfVIzM; Mon, 11 Jun 2018 18:50:20 +0000
Received: from thebollingers.org ([73.223.250.230])
        by resomta-po-05v.sys.comcast.net with ESMTPA
        id SRtQfTtYsfE91SRtSfEkSO; Mon, 11 Jun 2018 18:50:20 +0000
Date:   Mon, 11 Jun 2018 11:31:01 -0700
From:   Don Bollinger <don@thebollingers.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, brandon_chuang@edge-core.com,
        wally_wang@accton.com, roy_lee@edge-core.com,
        rick_burchett@edge-core.com, quentin.chang@quantatw.com,
        steven.noble@bigswitch.com, jeffrey.townsend@bigswitch.com,
        scotte@cumulusnetworks.com, roopa@cumulusnetworks.com,
        David Ahern <dsa@cumulusnetworks.com>,
        luke.williams@canonical.com, Guohan Lu <gulv@microsoft.com>,
        Xin Liu <xinxliu@microsoft.com>, steve.joiner@finisar.com
Subject: Re: [PATCH] optoe: driver to read/write SFP/QSFP EEPROMs
Message-ID: <20180611183101.s6meimftznf76eth@thebollingers.org>
References: <20180611042515.ml6zbcmz6dlvjmrp@thebollingers.org>
 <37dfd504-5921-54f2-b90e-a26595fc0a5e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37dfd504-5921-54f2-b90e-a26595fc0a5e@infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CMAE-Envelope: MS4wfPJUJcGgeZked1lxLGrCtxILriVqAtD6Bw9sLCNpx4G03/s16rw77oj6b1enYRJM/vUX628f0fWlnzON9v/w+jnP3w6F+PiVix6c7x+yoFeYSWWDO5Fh
 vghE4rpGkfJ7zJX0xhNHMX+gEYHlxFETQcEXLwqKE8MlBvVMC6av2eYOYQv0Yjf1VFV/plIPGqDXCGAxJYjmkAFSkX9K3gr3ffaAKAV0VMHYptPX99ASHFS3
 NXWWN/lkojWdV94l72r7A3J6mtjgR7CzWS+NCHbreBJq+urRLD/xCHlgFUfGemrueqn3XksnzJYRUdBRhJ1WUoOum+n3uV3nqmfKW+7MdYv1BGfs12OAI1u9
 va7yEjovp/taaKZtvJ4U1WWwNvV3MzRSqgLpeyJXQfmnuaILw1lIccUK5KAVx7lkzTTkwr/57DcwViwgzrXCsX1oSp8D0R9US93+W79lgLIuRMNR1cSbfY9o
 0tzEVwIt9GkBLwYGo2Nnu6sqDnlrd56PeupSjXoXXZq9uyZAfv91Cv5lIpZrNmILEzsBZcktKEJ35dxaXb7pz4ou/Arqk3BCJlBHPGcPI/mzyRwPeYcMuBYr
 J8s2fLKEV/99Kp+7tgF4Eu/lr9d1MrLVgMaS2idIhbpwVROkieV6KlNLWUvyjJ0W+xwd8dsyqm5CtwS3XUkV8vHr6l/2toOAjh6AcOaXXgd3PMrhpu+gU/vb
 8NdLsSTqtIan+qSm7NYaf036ONgNLc0h9h2gVmgF1PoOl9E2fquC5rPYq6otzXt2leez2vyADeLxZB67z6A5G5gnbeAhrJCUsDaQu1UOcCkBhadlmdfAxw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 09:56:00PM -0700, Randy Dunlap wrote:
> Hi,
> 
> On 06/10/2018 09:25 PM, Don Bollinger wrote:
> > diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
> > index 68a1ac929917..9a08e12756ee 100644
> > --- a/drivers/misc/eeprom/Kconfig
> > +++ b/drivers/misc/eeprom/Kconfig
> > @@ -111,4 +111,22 @@ config EEPROM_IDT_89HPESX
> >  	  This driver can also be built as a module. If so, the module
> >  	  will be called idt_89hpesx.
> >  
> > +config EEPROM_OPTOE
> > +	tristate "read/write access to SFP* & QSFP* EEPROMs"
> > +	depends on I2C && SYSFS
> > +	help
> > +	  If you say yes here you get support for read and write access to
> > +	  the EEPROM of SFP and QSFP type optical and copper transceivers.
> > +	  Includes all devices which conform to the sff-8436 and sff-8472
> 
> 	  This includes
> and then please s/sff/SFF/ (2 places).

Got it.  I'll make the changes in the next version.

Don
