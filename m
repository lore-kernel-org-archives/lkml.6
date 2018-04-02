Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeDBRUy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 13:20:54 -0400
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:40602 "EHLO
        resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753063AbeDBRUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 13:20:53 -0400
Date: Mon, 2 Apr 2018 12:20:51 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Rao Shoaib <rao.shoaib@oracle.com>
cc: linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        joe@perches.com, willy@infradead.org, brouer@redhat.com,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] kfree_rcu() should use kfree_bulk() interface
In-Reply-To: <1522647064-27167-3-git-send-email-rao.shoaib@oracle.com>
Message-ID: <alpine.DEB.2.20.1804021217070.24404@nuc-kabylake>
References: <1522647064-27167-1-git-send-email-rao.shoaib@oracle.com> <1522647064-27167-3-git-send-email-rao.shoaib@oracle.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfFMFPZU1tbXEQcmT/IbsogkiDjX6HY5U1zoSmu5K+uRxNeRLfPaPTVmUdMpoW4NhldkNL4m3lm4VDdXlrDHLXo/OA31CJQl/GVwMyhAceAsFPK6NkMXh
 vyewVkGGXbWFp30lAk+AAy4StmFx8IrdoBHPtJs9hAfKq7CIhEJ0jkQbzj2jmjbKGe8qrksob4wWuh28zqrs6oVZNDZvT3iVZRjekTF0MGik2FFjla1evVW8
 wygVov0Z00nOlGB+UtbFsXeuEJpR792IUC+ju3vpuXI04eBo9DypgV0I8E8YmYGX06X8VJWoOBZGo15r69VUwM6qAMEr+4463et8C/NpzJWt2gZIX/rNEy1A
 +yTfBS+b
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Apr 2018, rao.shoaib@oracle.com wrote:

> kfree_rcu() should use the new kfree_bulk() interface for freeing
> rcu structures as it is more efficient.

It would be even better if this approach could also use

	kmem_cache_free_bulk()

or

	kfree_bulk()
