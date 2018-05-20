Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeETDvf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 23:51:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42920 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752459AbeETDvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 23:51:32 -0400
Subject: Re: [ANNOUNCE] Kconfiglib menuconfig implementation
From: Randy Dunlap <rdunlap@infradead.org>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAFkk2KRTnRpi5thUGTM2+LZMyitggdJtiOBO7E0pTn93fz6-SQ@mail.gmail.com>
 <d4c3b2ab-385d-fe7a-bdb1-2d497d620de5@infradead.org>
 <CAFkk2KRozscmd4kQSJKwKmY3WpTody7S5XZZObf8SKLF62k6+w@mail.gmail.com>
 <CAFkk2KRkEt3+786QvyjzPPAm+3HDe2+ydzZJpshfdKyUDQVfuw@mail.gmail.com>
 <CAFkk2KRvSxu+x-nb045=3L63KEk5h9URr5QYLPoYp6rqqTR4qA@mail.gmail.com>
 <3d9be2f2-3fbe-411b-8529-0e0847f01346@infradead.org>
 <CAFkk2KRWon_S--dxYw82cDyGXKTFA6jxrrQwstzLvHPs=6-dqQ@mail.gmail.com>
 <c4ec710f-b2bd-b9f0-c33a-159aa53ca73c@infradead.org>
Message-ID: <3c56dfdf-d196-da34-35db-42b3675039dd@infradead.org>
Date: Sat, 19 May 2018 20:51:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c4ec710f-b2bd-b9f0-c33a-159aa53ca73c@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/19/2018 08:45 PM, Randy Dunlap wrote:
> On 05/08/2018 09:59 AM, Ulf Magnusson wrote:
>> Hello,
>>
>> I've added incremental search for jumping directly to a symbol now.
>> Regular expressions are supported as well.
>>
>> Some screenshots below:
>>
>> https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss10.png
>> https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss11.png
>> https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss13.png
>>
>> The last screenshot shows how things might look after you jump to a
>> symbol. The jumped-to symbol wasn't visible in this case, so show-all
>> mode was turned on automatically.
> 
> Hi Ulf,
> 
> 
> Hm, OK, I used the trick that you supplied a few weeks ago and I have the UI now.
> 
>     ARCH=x86 SRCARCH=x86 KERNELVERSION=`make kernelversion` \
>         Kconfiglib/menuconfig.py
> 
> so yes, a real Makefile target would be nice. :)


Enter: / (search)
then:  * (Bang) [this was just an unlucky typo on my part]

Traceback (most recent call last):
  File "/home/rdunlap/scripts/menuconfig.py", line 1447, in _jump_to_dialog
    for regex in s.split()]
  File "/home/rdunlap/scripts/menuconfig.py", line 1447, in <listcomp>
    for regex in s.split()]
  File "/usr/lib64/python3.4/re.py", line 223, in compile
    return _compile(pattern, flags)
  File "/usr/lib64/python3.4/re.py", line 294, in _compile
    p = sre_compile.compile(pattern, flags)
  File "/usr/lib64/python3.4/sre_compile.py", line 568, in compile
    p = sre_parse.parse(p, flags)
  File "/usr/lib64/python3.4/sre_parse.py", line 780, in parse
    p = _parse_sub(source, pattern, 0)
  File "/usr/lib64/python3.4/sre_parse.py", line 377, in _parse_sub
    itemsappend(_parse(source, state))
  File "/usr/lib64/python3.4/sre_parse.py", line 586, in _parse
    raise error("nothing to repeat")
sre_constants.error: nothing to repeat

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/home/rdunlap/scripts/menuconfig.py", line 2389, in <module>
    menuconfig(Kconfig("Kconfig" if len(sys.argv) < 2 else sys.argv[1]))
  File "/home/rdunlap/scripts/menuconfig.py", line 340, in menuconfig
    print(curses.wrapper(_menuconfig))
  File "/usr/lib64/python3.4/curses/__init__.py", line 94, in wrapper
    return func(stdscr, *args, **kwds)
  File "/home/rdunlap/scripts/menuconfig.py", line 483, in _menuconfig
    _jump_to_dialog()
  File "/home/rdunlap/scripts/menuconfig.py", line 1466, in _jump_to_dialog
    bad_re = e.msg
AttributeError: 'error' object has no attribute 'msg'



-- 
~Randy
