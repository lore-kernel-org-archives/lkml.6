Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754846AbeDTMxn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:53:43 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:1774 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbeDTMxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:53:41 -0400
X-IronPort-AV: E=Sophos;i="5.49,301,1520899200";
   d="scan'208";a="340670278"
Subject: Re: [PATCH 3/3] xen blkback: add fault injection facility
To: Juergen Gross <jgross@suse.com>
CC: <jakub.kicinski@netronome.com>, <hpa@zytor.com>, <mcroce@redhat.com>,
        <tglx@linutronix.de>, <ggarcia@abra.uab.cat>, <daniel@iogearbox.net>,
        <x86@kernel.org>, <mingo@redhat.com>, <xen-devel@lists.xenproject.org>,
        <axboe@kernel.dk>, <konrad.wilk@oracle.com>, <amir.jer.levy@intel.com>,
        <paul.durrant@citrix.com>, <stefanha@redhat.com>,
        <dsa@cumulusnetworks.com>, <boris.ostrovsky@oracle.com>,
        <linux-block@vger.kernel.org>, <wei.liu2@citrix.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <dwmw@amazon.co.uk>, <roger.pau@citrix.com>
References: <20180420104603.17823.31095.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
 <20180420104736.17823.42983.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
 <ef016b7b-6c0e-1684-5714-0a6d5a46504e@suse.com>
From: <staskins@amazon.com>
Message-ID: <403573a8-daeb-2e0e-fa31-e9bd160557fc@amazon.com>
Date: Fri, 20 Apr 2018 14:53:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ef016b7b-6c0e-1684-5714-0a6d5a46504e@suse.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3KCrpd4024337

On 04/20/18 13:28, Juergen Gross wrote:
> On 20/04/18 12:47, Stanislav Kinsburskii wrote:
>> This patch adds wrapper helpers around generic Xen fault inject
>> facility.
>> The major reason is to keep all the module fault injection directories
>> in a dedicated subdirectory instead of Xen fault inject root.
>>
>> IOW, when using these helpers, per-device and named by device name
>> fault injection control directories will appear under the following
>> directory:
>> - /sys/kernel/debug/xen/fault_inject/xen-blkback/
>> instead of:
>> - /sys/kernel/debug/xen/fault_inject/
>>
>> Signed-off-by: Stanislav Kinsburskii <staskins@amazon.com>
>> CC: Jens Axboe <axboe@kernel.dk>
>> CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> CC: "Roger Pau Monné" <roger.pau@citrix.com>
>> CC: linux-kernel@vger.kernel.org
>> CC: linux-block@vger.kernel.org
>> CC: xen-devel@lists.xenproject.org
>> CC: Stanislav Kinsburskii <staskins@amazon.com>
>> CC: David Woodhouse <dwmw@amazon.co.uk>
> This is an exact copy of the netback patch apart from the names.
>
> I don't like adding multiple copies of the same coding to the tree.

Sure, will dedupplicate this.

>
> Juergen
>

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
