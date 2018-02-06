Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeBFOwR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:52:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:55239 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751706AbeBFOwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:52:10 -0500
Subject: Re: [PATCH] pvcalls-back: do not return error on inet_accept EAGAIN
To: Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.10.1802021728420.10160@sstabellini-ThinkPad-X260>
From: Juergen Gross <jgross@suse.com>
Message-ID: <02c7c8ef-d8ed-2642-d178-2bde6c874028@suse.com>
Date: Tue, 6 Feb 2018 15:52:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1802021728420.10160@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/18 02:34, Stefano Stabellini wrote:
> When the client sends a regular blocking accept request, the backend is
> expected to return only when the accept is completed, simulating a
> blocking behavior, or return an error.
> 
> Specifically, on EAGAIN from inet_accept, the backend shouldn't return
> "EAGAIN" to the client. Instead, it should simply continue the wait.
> Otherwise, the client will send another accept request, which will cause
> another EAGAIN to be sent back, which is a waste of resources and not
> conforming to the expected behavior. Change the behavior by turning the
> "goto error" into a return.
> 
> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>

Committed to xen.tip for-linus-4.16


Juergen
