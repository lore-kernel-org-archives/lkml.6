Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbeETFuj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 01:50:39 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39427 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbeETFuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 01:50:37 -0400
X-Google-Smtp-Source: AB8JxZqHzXkNQuQ8IsAiXav0I++oH/zHUhCTm4x418toE+pv2bqSttdzi71xc3GUxqiEdPWZJ+o/BUG1F4sRDsEzQCA=
MIME-Version: 1.0
In-Reply-To: <CAFkk2KRaXVag4-gHOVLw4M1CaCSvvwAd8BxyDGQQf1YZAS1XYA@mail.gmail.com>
References: <CAFkk2KRTnRpi5thUGTM2+LZMyitggdJtiOBO7E0pTn93fz6-SQ@mail.gmail.com>
 <d4c3b2ab-385d-fe7a-bdb1-2d497d620de5@infradead.org> <CAFkk2KRozscmd4kQSJKwKmY3WpTody7S5XZZObf8SKLF62k6+w@mail.gmail.com>
 <CAFkk2KRkEt3+786QvyjzPPAm+3HDe2+ydzZJpshfdKyUDQVfuw@mail.gmail.com>
 <CAFkk2KRvSxu+x-nb045=3L63KEk5h9URr5QYLPoYp6rqqTR4qA@mail.gmail.com>
 <3d9be2f2-3fbe-411b-8529-0e0847f01346@infradead.org> <CAFkk2KRWon_S--dxYw82cDyGXKTFA6jxrrQwstzLvHPs=6-dqQ@mail.gmail.com>
 <c4ec710f-b2bd-b9f0-c33a-159aa53ca73c@infradead.org> <3c56dfdf-d196-da34-35db-42b3675039dd@infradead.org>
 <CAFkk2KRaXVag4-gHOVLw4M1CaCSvvwAd8BxyDGQQf1YZAS1XYA@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Sun, 20 May 2018 07:50:36 +0200
Message-ID: <CAFkk2KRHQ8h-+d2YPkD9gMx0o6UaXd362HhONgAqpDFdhXgbTg@mail.gmail.com>
Subject: Re: [ANNOUNCE] Kconfiglib menuconfig implementation
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 6:24 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> On Sun, May 20, 2018 at 5:51 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 05/19/2018 08:45 PM, Randy Dunlap wrote:
>>> On 05/08/2018 09:59 AM, Ulf Magnusson wrote:
>>>> Hello,
>>>>
>>>> I've added incremental search for jumping directly to a symbol now.
>>>> Regular expressions are supported as well.
>>>>
>>>> Some screenshots below:
>>>>
>>>> https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss10.png
>>>> https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss11.png
>>>> https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss13.png
>>>>
>>>> The last screenshot shows how things might look after you jump to a
>>>> symbol. The jumped-to symbol wasn't visible in this case, so show-all
>>>> mode was turned on automatically.
>>>
>>> Hi Ulf,
>>>
>>>
>>> Hm, OK, I used the trick that you supplied a few weeks ago and I have the UI now.
>>>
>>>     ARCH=x86 SRCARCH=x86 KERNELVERSION=`make kernelversion` \
>>>         Kconfiglib/menuconfig.py
>>>
>>> so yes, a real Makefile target would be nice. :)
>>
>>
>> Enter: / (search)
>> then:  * (Bang) [this was just an unlucky typo on my part]
>>
>> Traceback (most recent call last):
>>   File "/home/rdunlap/scripts/menuconfig.py", line 1447, in _jump_to_dialog
>>     for regex in s.split()]
>>   File "/home/rdunlap/scripts/menuconfig.py", line 1447, in <listcomp>
>>     for regex in s.split()]
>>   File "/usr/lib64/python3.4/re.py", line 223, in compile
>>     return _compile(pattern, flags)
>>   File "/usr/lib64/python3.4/re.py", line 294, in _compile
>>     p = sre_compile.compile(pattern, flags)
>>   File "/usr/lib64/python3.4/sre_compile.py", line 568, in compile
>>     p = sre_parse.parse(p, flags)
>>   File "/usr/lib64/python3.4/sre_parse.py", line 780, in parse
>>     p = _parse_sub(source, pattern, 0)
>>   File "/usr/lib64/python3.4/sre_parse.py", line 377, in _parse_sub
>>     itemsappend(_parse(source, state))
>>   File "/usr/lib64/python3.4/sre_parse.py", line 586, in _parse
>>     raise error("nothing to repeat")
>> sre_constants.error: nothing to repeat
>>
>> During handling of the above exception, another exception occurred:
>>
>> Traceback (most recent call last):
>>   File "/home/rdunlap/scripts/menuconfig.py", line 2389, in <module>
>>     menuconfig(Kconfig("Kconfig" if len(sys.argv) < 2 else sys.argv[1]))
>>   File "/home/rdunlap/scripts/menuconfig.py", line 340, in menuconfig
>>     print(curses.wrapper(_menuconfig))
>>   File "/usr/lib64/python3.4/curses/__init__.py", line 94, in wrapper
>>     return func(stdscr, *args, **kwds)
>>   File "/home/rdunlap/scripts/menuconfig.py", line 483, in _menuconfig
>>     _jump_to_dialog()
>>   File "/home/rdunlap/scripts/menuconfig.py", line 1466, in _jump_to_dialog
>>     bad_re = e.msg
>> AttributeError: 'error' object has no attribute 'msg'
>>
>>
>>
>> --
>> ~Randy
>
> Thanks for the report!
>
> Invalid regular expressions are detected, but it looks like the 'msg'
> field of re.error was added in Python 3.5 (you have 3.4).
>
> I'll check if the 'msg' field exists and fall back to just printing
> "Invalid regular expression" otherwise. The 'msg' field just gives a
> more informative error
> ("Bad regular expression: nothing to repeat" in this case).
>
> Cheers,
> Ulf

Fixed: https://github.com/ulfalizer/Kconfiglib/commit/3072e7338cfc63f2f81f34d02edc34dab3d9f365

Your environment seems to have a knack for finding stuff like that.

Cheers,
Ulf
