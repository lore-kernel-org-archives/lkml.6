Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934404AbeBLMOM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:14:12 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:51289 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933136AbeBLMOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:14:10 -0500
X-Google-Smtp-Source: AH8x226puXjiTAGmusfWOK6A3deT85bF+8gddFoOjJnioe/ijanaaF89jEufsywnn0t7FXBikVB/sw==
Subject: Re: ext4 iomap SEEK broken [was: [GIT PULL] ext4 updates for 4.15]
From: Jiri Slaby <jslaby@suse.cz>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20171113031502.f6mctmlmgk5psh77@thunk.org>
 <7ae851b1-92a8-779a-a066-1c7e34867465@suse.cz>
Message-ID: <45062110-e80c-f1e8-3710-743c1ae4d232@suse.cz>
Date: Mon, 12 Feb 2018 13:14:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7ae851b1-92a8-779a-a066-1c7e34867465@suse.cz>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018, 11:02 AM, Jiri Slaby wrote:
> Given this happens only on 32bit kernel, I assume some 32bit overflow.
> But I am unable to see it (yet).

Just to add, a diff of strace in good and bad kernels:
@@ -655,14 +655,4 @@
 _llseek(3, 4275568640, [4286054400], SEEK_DATA) = 0
 _llseek(3, 4286054400, [4288675840], SEEK_HOLE) = 0
 _llseek(3, 4288675840, [4299161600], SEEK_DATA) = 0
-_llseek(3, 4299161600, [4301783040], SEEK_HOLE) = 0
+_llseek(3, 4299161600, [4299161600], SEEK_HOLE) = 2621440

llseek returns a very invalid value when it comes to 0x100400000.

regards,
-- 
js
suse labs
