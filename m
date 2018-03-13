Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752625AbeCMRRx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:17:53 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:43090 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751727AbeCMRRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:17:52 -0400
Message-ID: <1520961470.5360.18.camel@HansenPartnership.com>
Subject: Re: [PATCH 2/5] MODSIGN: print appropriate status message when
 getting UEFI certificates list
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Lee, Chun-Yi" <jlee@suse.com>, David Howells <dhowells@redhat.com>
Cc: linux-fs@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Tue, 13 Mar 2018 10:17:50 -0700
In-Reply-To: <20180313103559.13032-3-jlee@suse.com>
References: <20180313103559.13032-1-jlee@suse.com>
         <20180313103559.13032-3-jlee@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-13 at 18:35 +0800, Lee, Chun-Yi wrote:
> When getting certificates list from UEFI variable, the original error
> message shows the state number from UEFI firmware. It's hard to be
> read by human. This patch changed the error message to show the
> appropriate string.
> 
> The message will be showed as:
> 
> [    0.788529] MODSIGN: Couldn't get UEFI MokListRT: EFI_NOT_FOUND
> [    0.788537] MODSIGN: Couldn't get UEFI MokListXRT: EFI_NOT_FOUND

I keep saying this, but these error messages need to be gated on the
presence of shim for the non-shim secure boot case.  You can't assume
the shim variables are there because they won't be in the case of a
fully owned system.

James
