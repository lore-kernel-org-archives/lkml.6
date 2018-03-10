Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AG47ELus1gtpaAA75DKYds7Scbhtx2zqTOXbH0/qD/rS84alhrRgzdgxBN8wE/v742nuK8R1IKn6
ARC-Seal: i=1; a=rsa-sha256; t=1520692876; cv=none;
        d=google.com; s=arc-20160816;
        b=ILHAn7x9lzHYFmXl2pSf7wQedfoWmTNQ3tB4ZYnQT6LjUU7wW6G7O4kKgqBRnPsJPK
         xUFGxO8t1ZjOgbU7hxqTMYeccwU345pCEVDMOZKk4W/PWov8wUaCqyENCTEVckYWEvF2
         YIhFSP/rxqmsnud8aRYuQkYbN+ckQfQ+Tgaz1uMA4TVfIGPaqrRu8ZhF3K31EbWv/KPt
         Z7u88elkJX8EyzRSNKRlCUXu+haFptq4BFDtAmAulUsBs6w3N6sqCNHgzimNVvdKJDlu
         mk9TSreC9fQOi6dPE/9uRqwnj/Ng0wtRQDkb1nbG6ZFOhJ40dDkt/WkNe3pynhEmm64o
         OiVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=mv7Z7Fi4ZfmS7GhMV4CvVxQCfp26vFGRvV7IctwU+tA=;
        b=GDHBtfE/Zwhq4FMDYh95j3Ll5wyufN/88td5vZI9+HKNmO8Zty8YSOQ0oWMiqaYzWq
         +nKefVhZQAeN3QAMvQYgFhGsuP+UqzFn2OnoVTDckF/yfzgS5xr3UnHnXzjU7tarlSjN
         Wwl7R9CENYp+n1q6AW8AnDIkjJNoFv1TU8Or5N3o8tWhB6kQ7tJJBmp/9P15HwPJiG3v
         O7tS2QraJYhcdNIrNgNdvkHxlNLtHnLS1VNRy2BGY2HfFHaccVsUsVITQCDKcTadwHRj
         dtJxDsk2XuIu7rBHX22cTtNIhwXS5715p1IoxzavE168yYLa0jwDm8wCw3kwkkhSD71X
         iDsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A3221795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
MIME-Version: 1.0
In-Reply-To: <CAB=NE6VY62KqmhzD=zT8od=PhgPi3rGKKKxKz_zad-ZrYW-97A@mail.gmail.com>
References: <20180309221243.15489-2-andresx7@gmail.com> <20180309230925.3573-1-andresx7@gmail.com>
 <CAB=NE6VY62KqmhzD=zT8od=PhgPi3rGKKKxKz_zad-ZrYW-97A@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Sat, 10 Mar 2018 06:40:54 -0800
X-Gmail-Original-Message-ID: <CAB=NE6XpY4LuDwnakCa6gZ_HjjhZDnu=gDeHwmpNRaSkqQOB2g@mail.gmail.com>
Message-ID: <CAB=NE6XpY4LuDwnakCa6gZ_HjjhZDnu=gDeHwmpNRaSkqQOB2g@mail.gmail.com>
Subject: Re: [PATCH] firmware: add a function to load optional firmware v2
To: Andres Rodriguez <andresx7@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594503439621024078?=
X-GMAIL-MSGID: =?utf-8?q?1594562053148348963?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 6:35 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> You also I take it have users in
> mind? I'd like to see at least one user of the API or this fixing a
> reported issue. Ie, if users have reported this as issues incorrectly,
> referring to those incorrect posts as issues and how this created
> confusion would help.

Your patch series then should also have the driver callers who you
want to modify to use this new API. Collect from the 802.11 folks the
other drivers which I think they wanted changed as well. The old up on
that front was that the firmware API was in a huge state of flux and
debate about *how* we'd evolve the API, either through a data driven
API or functional driven API, ie whether or not we'd add a flexible
one API call with a set of options, or keep extending functionality
with new exported symbols per use case. The later is how we'd keep
evolving the API as such the way you are doing it is fine. Ie, if
there is a use case for an optional firmware also for the async case a
new API call will have to be made. As stupid as this sounds.

Also please take a look at lib/test_firmware.c -- I don't think it
makes sense to add a new test case for this API call, so at least
worth documenting why somewhere if you find a suitable place for that.

Also - I forgot to ask you to extend the
Documentation/driver-api/firmware/ documentation accordingly. Please
do that.

  Luis
