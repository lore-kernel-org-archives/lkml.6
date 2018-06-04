Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbeFDQMk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:12:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45974 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeFDQMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:12:38 -0400
Subject: Re: linux-next: Tree for Jun 4 (fs/afs/)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <20180604215911.75399f6e@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7e4a317a-d57e-1499-dc1e-2eba35610632@infradead.org>
Date: Mon, 4 Jun 2018 09:12:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604215911.75399f6e@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2018 04:59 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20180601:
> 

on x86_64:

# CONFIG_PROC_FS is not set


../fs/afs/proc.c: In function ‘afs_proc_init’:
../fs/afs/proc.c:604:2: error: implicit declaration of function ‘proc_create_net_data_write’ [-Werror=implicit-function-declaration]
  if (!proc_create_net_data_write("cells", 0644, p,
  ^
../fs/afs/proc.c:609:6: error: implicit declaration of function ‘proc_create_net_single_write’ [-Werror=implicit-function-declaration]
      !proc_create_net_single_write("rootcell", 0644, p,
      ^
../fs/afs/proc.c: At top level:
../fs/afs/proc.c:517:12: warning: ‘afs_proc_stats_show’ defined but not used [-Wunused-function]
 static int afs_proc_stats_show(struct seq_file *m, void *v)
            ^
cc1: some warnings being treated as errors
../scripts/Makefile.build:311: recipe for target 'fs/afs/proc.o' failed


afs seems not to handle CONFIG_PROC_FS=n at all.

-- 
~Randy
