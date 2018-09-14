Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980A2FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A58A20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A58A20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeINOcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:32:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:34906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726898AbeINOcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:32:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3873ADEF;
        Fri, 14 Sep 2018 09:18:35 +0000 (UTC)
Subject: Re: Introduce xenwatch multithreading (mtwatch)
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, paul.durrant@citrix.com,
        wei.liu2@citrix.com, konrad.wilk@oracle.com, roger.pau@citrix.com,
        srinivas.eeda@oracle.com
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <145a7689-0b1c-3973-13c2-bb5749eb972b@suse.com>
Date:   Fri, 14 Sep 2018 11:18:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/18 09:34, Dongli Zhang wrote:
> Hi,
> 
> This patch set introduces xenwatch multithreading (mtwatch) based on the
> below xen summit 2018 design session notes:
> 
> https://lists.xenproject.org/archives/html/xen-devel/2018-07/msg00017.html
> 
> 
> xenwatch_thread is a single kernel thread processing the callback function
> for subscribed xenwatch events successively. The xenwatch is stalled in 'D'
> state if any of callback function is stalled and uninterruptible.
> 
> The domU create/destroy is failed if xenwatch is stalled in 'D' state as
> the paravirtual driver init/uninit cannot complete. Usually, the only
> option is to reboot dom0 server unless there is solution/workaround to
> move forward and complete the stalled xenwatch event callback function.
> Below is the output of 'xl create' when xenwatch is stalled (the issue is
> reproduced on purpose by hooking netif_receive_skb() to intercept an
> sk_buff sent out from vifX.Y on dom0 with patch at
> https://github.com/finallyjustice/patchset/blob/master/xenwatch-stall-by-vif.patch):
> 
> # xl create pv.cfg 
> Parsing config from pv.cfg
> libxl: error: libxl_device.c:1080:device_backend_callback: Domain 2:unable to add device with path /local/domain/0/backend/vbd/2/51712
> libxl: error: libxl_create.c:1278:domcreate_launch_dm: Domain 2:unable to add disk devices
> libxl: error: libxl_device.c:1080:device_backend_callback: Domain 2:unable to remove device with path /local/domain/0/backend/vbd/2/51712
> libxl: error: libxl_domain.c:1073:devices_destroy_cb: Domain 2:libxl__devices_destroy failed
> libxl: error: libxl_domain.c:1000:libxl__destroy_domid: Domain 2:Non-existant domain
> libxl: error: libxl_domain.c:959:domain_destroy_callback: Domain 2:Unable to destroy guest
> libxl: error: libxl_domain.c:886:domain_destroy_cb: Domain 2:Destruction of domain failed
> 
> 
> The idea of this patch set is to create a per-domU xenwatch thread for each
> domid. The per-domid thread is created when the 1st pv backend device (for
> this domid and with xenwatch multithreading enabled) is created, while this
> thread is destroyed when the last pv backend device (for this domid and
> with xenwatch multithreading enabled) is removed. Per-domid xs_watch_event
> is never put on the default event list, but is put on the per-domid event
> list directly.
> 
> 
> For more details, please refer to the xen summit 2018 design session notes
> and presentation slides:
> 
> https://lists.xenproject.org/archives/html/xen-devel/2018-07/msg00017.html
> http://www.donglizhang.org/xenwatch_multithreading.pdf
> 
> ----------------------------------------------------------------
> 
> Dongli Zhang (6):
>     xenbus: prepare data structures and parameter for xenwatch multithreading
>     xenbus: implement the xenwatch multithreading framework
>     xenbus: dispatch per-domU watch event to per-domU xenwatch thread
>     xenbus: process otherend_watch event at 'state' entry in xenwatch multithreading
>     xenbus: process be_watch events in xenwatch multithreading
>     drivers: enable xenwatch multithreading for xen-netback and xen-blkback driver
> 
>  Documentation/admin-guide/kernel-parameters.txt |   3 +
>  drivers/block/xen-blkback/xenbus.c              |   3 +-
>  drivers/net/xen-netback/xenbus.c                |   1 +
>  drivers/xen/xenbus/xenbus_probe.c               |  24 +-
>  drivers/xen/xenbus/xenbus_probe_backend.c       |  32 +++
>  drivers/xen/xenbus/xenbus_xs.c                  | 357 +++++++++++++++++++++++-
>  include/xen/xenbus.h                            |  70 +++++
>  7 files changed, 484 insertions(+), 6 deletions(-)
> 
> Thank you very much!

One general remark regarding your commit messages: Please drop the
patch number from the text itself, its enough to have it in the mail
subject line. Later it is completely irrelevant in git history.


Juergen

