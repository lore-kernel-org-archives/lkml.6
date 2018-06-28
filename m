Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99E1C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB1525DF1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB1525DF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933035AbeF1DQK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 23:16:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:58637 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932577AbeF1DQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 23:16:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6488BACC6;
        Thu, 28 Jun 2018 03:16:07 +0000 (UTC)
Date:   Thu, 28 Jun 2018 05:16:06 +0200
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH v8 1/5] ipc: IPCMNI limit check for msgmni and shmmni
Message-ID: <20180628031605.GJ21242@wotan.suse.de>
References: <1529317698-16575-1-git-send-email-longman@redhat.com>
 <1529317698-16575-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529317698-16575-2-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 06:28:14PM +0800, Waiman Long wrote:
> A user can write arbitrary integer values to msgmni and shmmni sysctl
> parameters without getting error, but the actual limit is really
> IPCMNI (32k). This can mislead users as they think they can get a
> value that is not real.
> 
> The right limits are now set for msgmni and shmmni so that the users
> will become aware if they set a value outside of the acceptable range.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

  Luis
