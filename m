Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932447AbeE3VQl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:16:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:43689 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753275AbeE3VQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:16:37 -0400
Message-ID: <8aaa7fa9874bf140354964535ce5cf023012c3f4.camel@kernel.crashing.org>
Subject: Re: [PATCH v7 3/7] drivers/i2c: Add port structure to FSI algorithm
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eddie James <eajames@linux.vnet.ibm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Edward A. James" <eajames@us.ibm.com>
Date: Thu, 31 May 2018 07:16:00 +1000
In-Reply-To: <ae3de08c-6849-bb3a-7c6c-96309876d48e@linux.vnet.ibm.com>
References: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com>
         <1527632665-25707-4-git-send-email-eajames@linux.vnet.ibm.com>
         <CAHp75Vd38BrJcULxoqj1mTKCEvMh9ZVYEvzCMAg2t9onZrSR6w@mail.gmail.com>
         <ae3de08c-6849-bb3a-7c6c-96309876d48e@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-30 at 10:47 -0500, Eddie James wrote:
> > > +       if (!list_empty(&i2c->ports)) {
> > 
> > My gosh, this is done already in list_for_each*()
> 
> No, list_for_each_entry does NOT check if the list is empty or if the 
> first entry is NULL.

NULL is never valid for a list. It does however check for an empty list

It does it implicitely in the test part of the for () statement,
checking if the next pointer points back to the head.

Cheers,
Ben.
