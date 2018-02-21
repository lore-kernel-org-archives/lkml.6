Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbeBUTwh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:52:37 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:45162 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBUTwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:52:35 -0500
X-Google-Smtp-Source: AG47ELttlzWT/0Q5zK6Pmo1/DPc9eE+LLJp1DejMo4eHdfcDQOoeIpLeDiSzjdK9IZYIR+TJYz12ANCv+fLTLTS3GC4=
MIME-Version: 1.0
In-Reply-To: <20180221182104.GI3231@tassilo.jf.intel.com>
References: <20180215182208.35003-2-joe.konno@linux.intel.com>
 <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org> <20180220211849.fqjb6rdmypl6opir@agluck-desk>
 <CA+55aFzjyB=E+=q-W9oYZ7Py7nJwm8YQHFjfbWTib6wvkP9B_A@mail.gmail.com>
 <20180220233008.55rfm7zw62hrao5p@agluck-desk> <CA+55aFy8JMLjpDk+sU6pirSZdVqqHtw5oocDAEC7wcHuo5Vssw@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37DE1B@ORSMSX110.amr.corp.intel.com>
 <CA+55aFwKsa6bq5SUD6wKv8znGcxqjLCPh33a3DkbnUkSfd68Yw@mail.gmail.com>
 <CAKv+Gu--iHii9SxE7RMZKdVdLvQPPGo0wdCzG30xW0+7dakbmw@mail.gmail.com>
 <CA+55aFx4Q7AzCM5mDwga6_LteNUBWQsT6nKJMjn8JcriS3ExuQ@mail.gmail.com> <20180221182104.GI3231@tassilo.jf.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Feb 2018 11:52:33 -0800
X-Google-Sender-Auth: 0M1s4uRWixnZBS5V2lUwi6_uW3c
Message-ID: <CA+55aFytF4-B8pV5+aoNUi8ZpeSpsTdik23_Ltq9=Vu-MH=JAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/efivarfs: restrict inode permissions
To: Andi Kleen <ak@linux.intel.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        Joe Konno <joe.konno@linux.intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 10:21 AM, Andi Kleen <ak@linux.intel.com> wrote:
>
> How about uid name spaces? Someone untrusted in a container could
> create a lot of uids and switch between them.

Anybody who does that deserves whatever the hell they get.

You can already blow out a lot of other resources that way. If you can
create users indiscriminately enough, you can bypass most other
resource limits too.

If you think containers protect against security issues from untrusted
users, I have a bridge to sell you.

              Linus
