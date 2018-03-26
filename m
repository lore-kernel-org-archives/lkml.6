Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752596AbeCZIeN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:34:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35008 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752570AbeCZIeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:34:10 -0400
Date: Mon, 26 Mar 2018 10:34:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/3] i2c: update i2c_trace_msg static key to modern api
Message-ID: <20180326083404.GF4043@hirez.programming.kicks-ass.net>
References: <20180325191056.24598-1-dave@stgolabs.net>
 <20180325191056.24598-2-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180325191056.24598-2-dave@stgolabs.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 25, 2018 at 12:10:54PM -0700, Davidlohr Bueso wrote:
> @@ -1848,11 +1848,11 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>  	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))
>  		return -EOPNOTSUPP;
>  
> -	/* i2c_trace_msg gets enabled when tracepoint i2c_transfer gets
> +	/* i2c_trace_msg_key gets enabled when tracepoint i2c_transfer gets
>  	 * enabled.  This is an efficient way of keeping the for-loop from
>  	 * being executed when not needed.
>  	 */
> -	if (static_key_false(&i2c_trace_msg)) {
> +	if (static_branch_unlikely(&i2c_trace_msg_key)) {

broken comment style.
