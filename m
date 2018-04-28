Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759858AbeD1KUw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 06:20:52 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:40625 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759752AbeD1KUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 06:20:50 -0400
X-Google-Smtp-Source: AB8JxZoEXID+nuze/jbiElNiC9MH64q84hJ+gPBMRkC39jQSlKGFIjooO+leX4f7U2NsBPHzxG7SJg==
Date: Sat, 28 Apr 2018 12:20:47 +0200
From: Ahmed Abdelsalam <amsalam20@gmail.com>
To: David Miller <davem@davemloft.net>
Cc: dav.lebrun@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next] ipv6: sr: Extract the right key values for
 "seg6_make_flowlabel"
Message-Id: <20180428122047.ede46582a46d87139e09eea1@gmail.com>
In-Reply-To: <20180427.135907.1528151032821602074.davem@davemloft.net>
References: <1524751871-1353-1-git-send-email-amsalam20@gmail.com>
        <20180427.135907.1528151032821602074.davem@davemloft.net>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.21; x86_64-apple-darwin10.8.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2018 13:59:07 -0400 (EDT)
David Miller <davem@davemloft.net> wrote:

> From: Ahmed Abdelsalam <amsalam20@gmail.com>
> Date: Thu, 26 Apr 2018 16:11:11 +0200
> 
> > @@ -119,6 +119,9 @@ int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
> >  	int hdrlen, tot_len, err;
> >  	__be32 flowlabel;
> >  
> > +	inner_hdr = ipv6_hdr(skb);
> 
> You have to make this assignment after, not before, the skb_cow_header()
> call.  Otherwise this point can be pointing to freed up memory.

Ok! 
I fixed and sent you a v2 of the patch. 

-- 
Ahmed Abdelsalam <amsalam20@gmail.com>
