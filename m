Date: Wed, 21 Feb 2018 12:40:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tommi Rantala <tommi.t.rantala@nokia.com>
Cc: Tahsin Erdogan <tahsin@google.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: backporting "ext4: inplace xattr block update fails to
 deduplicate blocks" to LTS kernels?
Message-ID: <20180221114000.GB6555@kroah.com>
References: <f3db4b3f-9cb6-c96c-8d31-f2a5f8b4082c@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3db4b3f-9cb6-c96c-8d31-f2a5f8b4082c@nokia.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 19, 2018 at 03:26:37PM +0200, Tommi Rantala wrote:
> Hi,
> 
> 4.9 (and earlier) LTS kernels are missing this:
> 
> commit ec00022030da5761518476096626338bd67df57a
> Author: Tahsin Erdogan <tahsin@google.com>
> Date:   Sat Aug 5 22:41:42 2017 -0400
> 
>     ext4: inplace xattr block update fails to deduplicate blocks
> 
> 
> OK to backport it?
> I tested it briefly in 4.9, seems to work.
> 
> One of our testers noticed a glusterfs performance regression when going
> from 4.4 to 4.9, caused by the duplicated blocks.
> 
> In I understand everything correctly, in 4.4 mbcache uses the block number
> in the hash table bucket calculation, and the hash table is populated quite
> evenly even if there are duplicates. So the mbcache is fast.
> 
> But in later kernels mbcache puts all the duplicate entries into a single
> bucket. As the entries are stored in one big linked list, this obviously
> makes the mbcache slow.
> 
> 
> I tested this in 4.9 (which still has the ext4_xattr_rehash() call that got
> eliminated in commit "ext4: eliminate xattr entry e_hash recalculation for
> removes"):

I need an ack from the ext4 maintainers before I can take this...
