Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981A4C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD12214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD12214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeJSDqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 23:46:32 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:45016 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbeJSDqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 23:46:32 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w9IJhjeW001890;
        Thu, 18 Oct 2018 20:43:45 +0100
Date:   Thu, 18 Oct 2018 20:43:44 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: uinput - fix Spectre v1 vulnerability
Message-ID: <20181018204344.4c135203@alans-desktop>
In-Reply-To: <2856297d-9af0-e005-f926-e9596d437fad@embeddedor.com>
References: <20181016111313.GA28307@embeddedor.com>
        <20181016172107.GA230131@dtor-ws>
        <ead3e95a-1acb-362a-0ee2-d02dbc4f378c@embeddedor.com>
        <26EEA6BC-43B0-42F7-A237-572D32EB2309@gmail.com>
        <2856297d-9af0-e005-f926-e9596d437fad@embeddedor.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 20:12:43 +0200
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> On 10/16/18 8:09 PM, Dmitry Torokhov wrote:
> 
> > 
> > /dev/uinput   
> 
> I've got it. This explains it all. :)
> 
> > must be 0600, or accessible to equally privileged user, or you'll be opening your system to much mischief.

Still a correct change.

CAP_SYS_RAWIO is not the same as being root, especially in a container.

Alan
