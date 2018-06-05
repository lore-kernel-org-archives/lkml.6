Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752434AbeFEN5G (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:57:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751690AbeFEN5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:57:04 -0400
Date: Tue, 5 Jun 2018 08:57:01 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Jessica Yu <jeyu@kernel.org>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH] module: exclude SHN_UNDEF symbols from kallsyms api
Message-ID: <20180605135701.hfoxr5tkz7svmwkn@treble>
References: <20180605084223.20556-1-jeyu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180605084223.20556-1-jeyu@kernel.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 10:42:23AM +0200, Jessica Yu wrote:
> Livepatch modules are special in that we preserve their entire symbol
> tables in order to be able to apply relocations after module load. The
> unwanted side effect of this is that undefined (SHN_UNDEF) symbols of
> livepatch modules are accessible via the kallsyms api and this can
> confuse symbol resolution in livepatch (klp_find_object_symbol()) and
> cause subtle bugs in livepatch.
> 
> Have the module kallsyms api skip over SHN_UNDEF symbols. These symbols
> are usually not available for normal modules anyway as we cut down their
> symbol tables to just the core (non-undefined) symbols, so this should
> really just affect livepatch modules. Note that this patch doesn't
> affect the display of undefined symbols in /proc/kallsyms.
> 
> Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Tested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Jessica Yu <jeyu@kernel.org>

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
