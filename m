Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbeC0PuL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:50:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:53150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752254AbeC0PuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:50:10 -0400
Date: Tue, 27 Mar 2018 08:37:51 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: David Miller <davem@davemloft.net>
Cc: peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, dbueso@suse.de
Subject: Re: [PATCH 5/6] net/ipv4: Update ip_tunnel_metadata_cnt static key
 to modern api
Message-ID: <20180327153751.52xzpcafm7gda44a@linux-n805>
References: <20180326210929.5244-1-dave@stgolabs.net>
 <20180326210929.5244-6-dave@stgolabs.net>
 <20180327.114402.619275306009710582.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180327.114402.619275306009710582.davem@davemloft.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018, David Miller wrote:

>From: Davidlohr Bueso <dave@stgolabs.net>
>Date: Mon, 26 Mar 2018 14:09:28 -0700
>
>> No changes in refcount semantics -- key init is false; replace
>>
>> static_key_slow_inc|dec   with   static_branch_inc|dec
>> static_key_false          with   static_branch_unlikely
>>
>> Added a '_key' suffix to i2c_trace_msg, for better self
>> documentation.
>
>I see no reference to i2c_trace_msg in this patch.

Sorry, that was from a previous changelog. The reason why it was not updated was
because I chose not to rename to ip_tunnel_metadata_cnt_key, so the whole sentence
needed removal. Do you want a v3 or can you pick up as is?

Thanks,
Davidlohr
