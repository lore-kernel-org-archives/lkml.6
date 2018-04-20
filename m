Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754852AbeDTNCr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:02:47 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:51296 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbeDTNCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:02:45 -0400
X-IronPort-AV: E=Sophos;i="5.49,301,1520899200";
   d="scan'208";a="727251686"
Subject: Re: [PATCH 2/3] xen netback: add fault injection facility
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
 <20180420104731.17823.97617.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
 <e33c055c-5a5a-2329-7a2e-faf715bb95fc@suse.com>
 <909fd3b2-19e8-8c13-6ede-cfd6051c6f1d@amazon.com>
 <5c4e4f3d-03ce-b517-d451-3229c0d542c0@suse.com>
From: <staskins@amazon.com>
Message-ID: <d205346f-d77a-8e5c-753d-c05623a6c55a@amazon.com>
Date: Fri, 20 Apr 2018 15:02:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5c4e4f3d-03ce-b517-d451-3229c0d542c0@suse.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3KD2ric024441

On 04/20/18 15:00, Juergen Gross wrote:
> On 20/04/18 14:52, staskins@amazon.com wrote:
>> On 04/20/18 13:25, Juergen Gross wrote:
>>> On 20/04/18 12:47, Stanislav Kinsburskii wrote:
>>>> +    for (fi = 0; fi < XENVIF_FI_MAX; fi++) {
>>>> +        vfi->faults[fi] = xen_fi_dir_add(vfi->dir,
>>>> +                xenvif_fi_names[fi]);
>>> How does this work? xenvif_fi_names[] is an empty array and this is the
>>> only reference to it. Who is allocating the memory for that array?
>> Well, it works in the way one adds a var to enum (which is used as a key
>> later) and a corresponding string into the array (which is used as a
>> name for the fault directory in sysfs).
> Then you should size the array via XENVIF_FI_MAX.

Makes sense.
Thanks!

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
