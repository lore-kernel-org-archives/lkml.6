Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753406AbeEURlm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:41:42 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:40839 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753621AbeEURkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:40:06 -0400
X-Google-Smtp-Source: AB8JxZp0TUiMEz2ewwgVEMqOIJPJskPhGOxEAh4JqOsUEOwa0GuUtRfl8k893oLV//qTCRJ6xZKY5w==
Date: Tue, 22 May 2018 02:39:59 +0900
From: Jungsub Shin <supsup5642@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Why is the length of max mount option a page size??
Message-ID: <20180521173959.GA12779@supsup-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, now i'm interested in mount lenght of max mount option.
I anaylsis ksys_mount() function in /fs/namespace.c. and find out 
the length of max mount option is a page size (4096 bytes).

I know that almost mount option short and page size is enough to
contain almost mount options. but because of options for 
unionfs(overlay, aufs), lenght of mount option could be exceed it
and cut.

I suffer this problem with aufs. aufs's branch option is cut and 
fail to aufs mount. I know that aufs is not offical fs in linux, 
but overlay fs now support multi layer mount option and could be 
suffer the same problem.

I think the best is dynamic allocate mount option's kernel memory. 
but I'm only have shallow knowlege of kernel, I can't guess it.
And I think If the length of mount option cannot exceed a page size, 
kernel must leave warning messsage about lenght and return err.
copy_mount_options() function seems to done this.
