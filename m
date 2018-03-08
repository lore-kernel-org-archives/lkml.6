Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965186AbeCHQ1p (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:27:45 -0500
Received: from mail2015.choopa.net ([208.167.225.251]:12229 "EHLO
        mail2015.choopa.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbeCHQ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:27:44 -0500
Authentication-Results: mail2015.choopa.net; dmarc=none header.from=gameservers.com
To: linux-kernel@vger.kernel.org
From: Brian Rak <brak@gameservers.com>
Subject: Hang while booting 4.15.7
Message-ID: <5fcd1a79-02c0-313a-5689-06cfa2c0219d@gameservers.com>
Date: Thu, 8 Mar 2018 11:21:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have some Dell servers running Intel Gold 6126 processors. Some of 
them hang on boot under 4.15.7,  but work fine on 4.14.14.  When they 
hang, we see the following on console:

Error parsing PCC subspaces from PCCT
watchdog: BUG: soft lockup - CPU #16 stuck for 23s! [swapper/0:1]

We see that PCC subspaces error under 4.14 as well, but it doesn't cause 
the machine to hang.

So far we haven't been able to correlate these hangs with anything in 
particular.  Some machines will hang, some machines will boot.  They're 
otherwise identical as far as hardware and firmware goes.

I've tried pcie_aspm=off, since that seems to be the next bit of code 
that's being executed.  This resulted in the machine booting a little 
further, but then oopsing somewhere in acpi_os_purge_cache. I'm not able 
to get a full trace there, as I don't have serial access easily available.

Any suggestions?
