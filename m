Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932908AbeCEVjP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 16:39:15 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35242 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932427AbeCEVjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 16:39:13 -0500
X-Google-Smtp-Source: AG47ELus07xhona/FBK21BgoSdAjKPBFtLHaUhZuTP346WS2O9EElggj6/vPRvJX4JahDbBXBWvc4g==
Date: Mon, 5 Mar 2018 15:39:10 -0600
From: Rob Herring <robh@kernel.org>
To: frowand.list@gmail.com
Cc: pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
Subject: Re: [PATCH v2 1/2] of: unittest: clean up changeset test
Message-ID: <20180305213910.olvnsprxw4rpjkzv@rob-hp-laptop>
References: <1519682483-19828-1-git-send-email-frowand.list@gmail.com>
 <1519682483-19828-2-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519682483-19828-2-git-send-email-frowand.list@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 02:01:22PM -0800, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> In preparation for fixing __of_node_dup(), clean up the unittest
> function that calls it.
> 
> Devicetree nodes created from a flattened device tree have a name
> property.  Follow this convention for nodes added by a changeset.

I'd like to get rid of that property as it should be redundant, but 
that's somewhat orthogonal to this.

It also shouldn't be up to the caller to have to do this either, but 
that's already broken in the current API.

So I've applied these.

> 
> For node added by changeset, remove incorrect initialization of
> child node pointer.
> 
> Add an additional node pointer 'changeset' to more naturally reflect
> where in the tree the changeset is added.
> 
> Make changeset add property error messages unique.
> 
> Add whitespace to break apart logic blocks.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
