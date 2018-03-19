Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966560AbeCSVJH convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965426AbeCSVI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:08:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A5620838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Mike Looijmans <mike.looijmans@topic.nl>,
        Rob Herring <robh@kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <ec813ab3-88db-f6e3-eca1-b6ea58936fcf@topic.nl>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        mark.rutland@arm.com
References: <1521114608-21967-1-git-send-email-mike.looijmans@topic.nl>
 <20180318125219.ar7f2n4o73ljz6vg@rob-hp-laptop>
 <ec813ab3-88db-f6e3-eca1-b6ea58936fcf@topic.nl>
Message-ID: <152149373621.242365.4815290210815209160@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] clk: Add driver for the si544 clock generator chip
Date: Mon, 19 Mar 2018 14:08:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Looijmans (2018-03-19 08:04:15)
> On 18-03-18 13:52, Rob Herring wrote:
> > On Thu, Mar 15, 2018 at 12:50:08PM +0100, Mike Looijmans wrote:
> >> +Required properties:
> >> + - compatible: One of "silabs,si514a", "silabs,si514b" "silabs,si514c" according
> >> +               to the speed grade of the chip.
> >> + - reg: I2C device address.
> >> + - #clock-cells: From common clock bindings: Shall be 0.
> >> +
> >> +Optional properties:
> >> + - clock-output-names: From common clock bindings. Recommended to be "si544".
> > 
> > What's the point if there is only 1 clock output?
> 
> I have a board with 6 of these chips, and the clock registration fails if they 
> don't have unique names. Providing a clock-output-names property was the 
> easiest way around it.
> 
> Should I just omit the line or change the wording to reflect the above or is 
> there a better solution (maybe I can use the DT node name as clock name in the 
> driver, will look into that)

I would leave clock-output-names for now. One day we can get off of
strings in CCF. Soon perhaps.

> 
> > 
> >> +
> >> +Example:
> >> +    si544: clock-generator@55 {
> > 
> > clock-controller@55 is the standard node name.
> 
> I'll change and post patch v3
> 

I made some comments on v1. Please fold those into v3.
