Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33803C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0E2206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="AbaDsnEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0E2206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeIERjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:39:03 -0400
Received: from imap.thunk.org ([74.207.234.97]:53160 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbeIERjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hGD3PGefPjm9W9XJGyvau3Z42CUUVTVvQuVIGhuVj+g=; b=AbaDsnEyu/E7Js+EXcIxwgmW28
        M7bI0A+ViAjd0v76nDIuA+k5d2DzWkt7kr+8HaHtsL+pUBikhDLeC2rW6X4whvi+ZLu9YYNbjisnx
        FuZCxrPautwLmDCvS3TJIinJ6ExnqGoHxkxbEY350cSEthEWFfzxIVFdhWe3tnyHz5xg=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fxXY7-0003kf-I0; Wed, 05 Sep 2018 13:08:47 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 71DB97A0068; Wed,  5 Sep 2018 09:08:45 -0400 (EDT)
Date:   Wed, 5 Sep 2018 09:08:45 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>
Cc:     jlayton@redhat.com, R.E.Wolff@bitwizard.nl,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: POSIX violation by writeback error
Message-ID: <20180905130845.GE23909@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        jlayton@redhat.com, R.E.Wolff@bitwizard.nl,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
 <20180904075347.GH11854@BitWizard.nl>
 <CAJDTihzqn3whQ47uUOxGYk4Je4S10ehNEQCtfb=j--iCsdDqgQ@mail.gmail.com>
 <82ffc434137c2ca47a8edefbe7007f5cbecd1cca.camel@redhat.com>
 <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com>
 <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
 <CAJDTihzO0Y0ZE8em2LqT-Ac-Kga7W51Uwwb2uv9oTFhkJ8vKgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJDTihzO0Y0ZE8em2LqT-Ac-Kga7W51Uwwb2uv9oTFhkJ8vKgA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 04:09:42PM +0800, 焦晓冬 wrote:
> Well, since the reader application and the writer application are reading
> a same file, they are indeed related. The reader here is expecting
> to read the lasted data the writer offers, not any data available. The
> reader is surely not expecting to read partially new and partially old data.
> Right? And, that `read() should return the lasted write()` by POSIX
> supports this expectation.

Unix, and therefore Linux's, core assumption is that the primary
abstraction is the file.  So if you say that all applications which
read or write the same file, that's equivalent of saying, "all
applications are related".  Consider that a text editor can read a
config file, or a source file, or any other text file.  Consider shell
script commands such as "cat", "sort", "uniq".  Heck /bin/cp copies
any type of file.  Does that mean that /bin/cp, as a reader
application, is related to all applications on the system.

The real problem here is that we're trying to guess the motivations
and usage of programs that are reading the file, and there's no good
way to do that.  It could be that the reader is someone who wants to
be informed that file is in page cache, but was never persisted to
disk.  It could be that the user has figured out something has gone
terribly wrong, and is desperately trying to rescue all the data she
can by copying it to another disk.  In that case, stopping the reader
from being able to access the contents is exactly the wrong thing to
do if what you care about is preventing data loss.

The other thing which you seem to be assuming is that applications
which care about precious data won't use fsync(2).  And in general,
it's been fairly well known for decades that if you care about your
data, you have to use fsync(2) or O_DIRECT writes; and you *must*
check the error return of both the fsync(2) and the close(2) system
calls.  Emacs got that right in the mid-1980's --- over 30 years ago.
We mocked GNOME and KDE's toy notepad applications for getting this
wrong a decade ago, and they've since fixed it.

Actually, the GNOME and KDE applications, because they were too lazy
to persist the xattr and ACL's, decided it was better to truncate the
file and then rewrite it.  So if you crashed after the
truncate... your data was toast.  This was a decade ago, and again, it
was considered spectacular bad application programming then, and it's
since been fixed.  The point here is that there will always be lousy
application programs.  And it is a genuine systems design question how
much should we sacrifice performance and efficiency to accomodate
stupid application programs.

For example, we could make close(2) imply an fsync(2), and return the
error in close(2).  But *that* assumes that applications actually
check the return value for close(2) --- and there will be those that
don't.  This would completely trash performance for builds, since it
would slow down writing generated files such as all the *.o object
files.  Which since they are generated files, they aren't precious.
So forcing an fsync(2) after writing all of those files will destroy
your system performance.

						- Ted
