Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbeCFTNi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 14:13:38 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33259 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753747AbeCFTNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 14:13:35 -0500
X-Google-Smtp-Source: AG47ELtM4MBiAJrJuOUMfPM9vCzm0QDfeAThDC0dBp4qZRs6H1o+/skS6AUxKEmR14X6ctJt2y3BdVXiOsKvtAni9To=
MIME-Version: 1.0
In-Reply-To: <20180305184219.GA30168@linux.intel.com>
References: <20180227172952.22177-1-ross.zwisler@linux.intel.com> <20180305184219.GA30168@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 6 Mar 2018 11:13:33 -0800
Message-ID: <CAPcyv4iR-AMOK0wphTm4cPxypjv_z=qwPJvKs__1md1qbPvJOg@mail.gmail.com>
Subject: Re: [PATCH 1/3] nfit_test: improve structure offset handling
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 5, 2018 at 10:42 AM, Ross Zwisler
<ross.zwisler@linux.intel.com> wrote:
> On Tue, Feb 27, 2018 at 10:29:50AM -0700, Ross Zwisler wrote:
>> In nfit_test0_setup() and nfit_test1_setup() we keep an 'offset' value
>> which we use to calculate where in our 'nfit_buf' we will place our next
>> structure.  The handling of 'offset' and the calculation of the placement
>> of the next structure is a bit inconsistent, though.  We don't update
>> 'offset' after we insert each structure, sometimes causing us to update it
>> for multiple structures' sizes at once.  When calculating the position of
>> the next structure we aren't always able to just use 'offset', but
>> sometimes have to add in other structure sizes as well.
>>
>> Fix this by updating 'offset' after each structure insertion in a
>> consistent way, allowing us to always calculate the position of the next
>> structure to be inserted by just using 'nfit_buf + offset'.
>>
>> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
>
> Ping on this series.

All of these look good to me, applied.
