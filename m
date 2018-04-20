Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752144AbeDTUE7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 16:04:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:22123 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750985AbeDTUE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 16:04:57 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,303,1520924400";
   d="gz'50?scan'50,208,50";a="222113600"
Date: Sat, 21 Apr 2018 04:04:47 +0800
From: kbuild test robot <lkp@intel.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: kbuild-all@01.org, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: add duty cycle support
Message-ID: <201804210438.gtqycO0K%fengguang.wu@intel.com>
References: <20180420153431.13003-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20180420153431.13003-1-jbrunet@baylibre.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jerome,

I love your patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.17-rc1 next-20180420]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jerome-Brunet/clk-add-duty-cycle-support/20180421-021133
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: powerpc-ppc6xx_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

    #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
                                   ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:399:6: note: in expansion of macro 'offsetof'
         offsetof(typeof(field), item),  \
         ^~~~~~~~
   include/trace/trace_events.h:415:29: note: in expansion of macro '__field_ext'
    #define __field(type, item) __field_ext(type, item, FILTER_OTHER)
                                ^~~~~~~~~~~
   include/trace/events/clk.h:203:3: note: in expansion of macro '__field'
      __field( unsigned int,           duty->num               )
      ^~~~~~~
   include/trace/trace_events.h:400:18: error: 'struct trace_event_raw_clk_duty_cycle' has no member named 'duty'
         sizeof(field.item),   \
                     ^
   include/trace/trace_events.h:454:2: note: in definition of macro 'DECLARE_EVENT_CLASS'
     tstruct;       \
     ^~~~~~~
   include/trace/events/clk.h:201:2: note: in expansion of macro 'TP_STRUCT__entry'
     TP_STRUCT__entry(
     ^~~~~~~~~~~~~~~~
   include/trace/trace_events.h:415:29: note: in expansion of macro '__field_ext'
    #define __field(type, item) __field_ext(type, item, FILTER_OTHER)
                                ^~~~~~~~~~~
   include/trace/events/clk.h:203:3: note: in expansion of macro '__field'
      __field( unsigned int,           duty->num               )
      ^~~~~~~
   include/linux/compiler-gcc.h:166:2: error: 'struct trace_event_raw_clk_duty_cycle' has no member named 'duty'
     __builtin_offsetof(a, b)
     ^
   include/trace/trace_events.h:454:2: note: in definition of macro 'DECLARE_EVENT_CLASS'
     tstruct;       \
     ^~~~~~~
   include/trace/events/clk.h:201:2: note: in expansion of macro 'TP_STRUCT__entry'
     TP_STRUCT__entry(
     ^~~~~~~~~~~~~~~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
    #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
                                   ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:399:6: note: in expansion of macro 'offsetof'
         offsetof(typeof(field), item),  \
         ^~~~~~~~
   include/trace/trace_events.h:415:29: note: in expansion of macro '__field_ext'
    #define __field(type, item) __field_ext(type, item, FILTER_OTHER)
                                ^~~~~~~~~~~
   include/trace/events/clk.h:204:3: note: in expansion of macro '__field'
      __field( unsigned int,           duty->den               )
      ^~~~~~~
   include/trace/trace_events.h:400:18: error: 'struct trace_event_raw_clk_duty_cycle' has no member named 'duty'
         sizeof(field.item),   \
                     ^
   include/trace/trace_events.h:454:2: note: in definition of macro 'DECLARE_EVENT_CLASS'
     tstruct;       \
     ^~~~~~~
   include/trace/events/clk.h:201:2: note: in expansion of macro 'TP_STRUCT__entry'
     TP_STRUCT__entry(
     ^~~~~~~~~~~~~~~~
   include/trace/trace_events.h:415:29: note: in expansion of macro '__field_ext'
    #define __field(type, item) __field_ext(type, item, FILTER_OTHER)
                                ^~~~~~~~~~~
   include/trace/events/clk.h:204:3: note: in expansion of macro '__field'
      __field( unsigned int,           duty->den               )
      ^~~~~~~
   In file included from include/trace/define_trace.h:96:0,
                    from include/trace/events/clk.h:234,
                    from drivers//clk/clk.c:84:
   include/trace/events/clk.h: In function 'trace_event_get_offsets_clk_duty_cycle':
   include/linux/compiler-gcc.h:166:2: error: 'struct trace_event_raw_clk_duty_cycle' has no member named '__data'
     __builtin_offsetof(a, b)
     ^
   include/trace/trace_events.h:534:2: note: in definition of macro 'DECLARE_EVENT_CLASS'
     tstruct;       \
     ^~~~~~~
   include/trace/events/clk.h:201:2: note: in expansion of macro 'TP_STRUCT__entry'
     TP_STRUCT__entry(
     ^~~~~~~~~~~~~~~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
    #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
                                   ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:494:11: note: in expansion of macro 'offsetof'
              offsetof(typeof(*entry), __data); \
              ^~~~~~~~
   include/trace/trace_events.h:499:29: note: in expansion of macro '__dynamic_array'
    #define __string(item, src) __dynamic_array(char, item,   \
                                ^~~~~~~~~~~~~~~
   include/trace/events/clk.h:202:3: note: in expansion of macro '__string'
      __string(        name,           core->name              )
      ^~~~~~~~
   In file included from include/trace/define_trace.h:96:0,
                    from include/trace/events/clk.h:234,
                    from drivers//clk/clk.c:84:
   include/trace/events/clk.h: In function 'trace_event_raw_event_clk_duty_cycle':
   include/trace/events/clk.h:199:21: error: 'num' undeclared (first use in this function)
          TP_ARGS(core, num, den),
                        ^
   include/trace/trace_events.h:709:64: note: in definition of macro 'DECLARE_EVENT_CLASS'
     __data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
                                                                   ^~~~
   include/trace/events/clk.h:199:7: note: in expansion of macro 'TP_ARGS'
          TP_ARGS(core, num, den),
          ^~~~~~~
>> include/trace/events/clk.h:199:26: error: 'den' undeclared (first use in this function); did you mean '_end'?
          TP_ARGS(core, num, den),
                             ^
   include/trace/trace_events.h:709:64: note: in definition of macro 'DECLARE_EVENT_CLASS'
     __data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
                                                                   ^~~~
   include/trace/events/clk.h:199:7: note: in expansion of macro 'TP_ARGS'
          TP_ARGS(core, num, den),
          ^~~~~~~
   include/trace/trace_events.h:709:16: error: too many arguments to function 'trace_event_get_offsets_clk_duty_cycle'
     __data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
                   ^
   include/trace/events/clk.h:195:1: note: in expansion of macro 'DECLARE_EVENT_CLASS'
    DECLARE_EVENT_CLASS(clk_duty_cycle,
    ^~~~~~~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:96:0,
                    from include/trace/events/clk.h:234,
                    from drivers//clk/clk.c:84:
   include/trace/trace_events.h:527:27: note: declared here
    static inline notrace int trace_event_get_offsets_##call(  \
                              ^
   include/trace/events/clk.h:195:1: note: in expansion of macro 'DECLARE_EVENT_CLASS'
    DECLARE_EVENT_CLASS(clk_duty_cycle,
    ^~~~~~~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:96:0,
                    from include/trace/events/clk.h:234,
                    from drivers//clk/clk.c:84:
   include/trace/events/clk.h:209:10: error: 'struct trace_event_raw_clk_duty_cycle' has no member named 'num'
      __entry->num = num;
             ^
   include/trace/trace_events.h:719:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/events/clk.h:207:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/trace/events/clk.h:210:10: error: 'struct trace_event_raw_clk_duty_cycle' has no member named 'den'
      __entry->den = den;
             ^
   include/trace/trace_events.h:719:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/events/clk.h:207:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:97:0,
                    from include/trace/events/clk.h:234,
                    from drivers//clk/clk.c:84:
   include/trace/events/clk.h: In function 'perf_trace_clk_duty_cycle':
   include/trace/events/clk.h:199:21: error: 'num' undeclared (first use in this function)
          TP_ARGS(core, num, den),
                        ^
   include/trace/perf.h:46:64: note: in definition of macro 'DECLARE_EVENT_CLASS'
     __data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
                                                                   ^~~~
   include/trace/events/clk.h:199:7: note: in expansion of macro 'TP_ARGS'
          TP_ARGS(core, num, den),
          ^~~~~~~
>> include/trace/events/clk.h:199:26: error: 'den' undeclared (first use in this function); did you mean '_end'?
          TP_ARGS(core, num, den),
                             ^
   include/trace/perf.h:46:64: note: in definition of macro 'DECLARE_EVENT_CLASS'
     __data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
                                                                   ^~~~
   include/trace/events/clk.h:199:7: note: in expansion of macro 'TP_ARGS'
          TP_ARGS(core, num, den),
          ^~~~~~~
   include/trace/perf.h:46:16: error: too many arguments to function 'trace_event_get_offsets_clk_duty_cycle'
     __data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
                   ^
   include/trace/events/clk.h:195:1: note: in expansion of macro 'DECLARE_EVENT_CLASS'
    DECLARE_EVENT_CLASS(clk_duty_cycle,
    ^~~~~~~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:96:0,
                    from include/trace/events/clk.h:234,
                    from drivers//clk/clk.c:84:
   include/trace/trace_events.h:527:27: note: declared here
    static inline notrace int trace_event_get_offsets_##call(  \
                              ^
   include/trace/events/clk.h:195:1: note: in expansion of macro 'DECLARE_EVENT_CLASS'
    DECLARE_EVENT_CLASS(clk_duty_cycle,
    ^~~~~~~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:97:0,
                    from include/trace/events/clk.h:234,
                    from drivers//clk/clk.c:84:
   include/trace/events/clk.h:209:10: error: 'struct trace_event_raw_clk_duty_cycle' has no member named 'num'
      __entry->num = num;
             ^
   include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/events/clk.h:207:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/trace/events/clk.h:210:10: error: 'struct trace_event_raw_clk_duty_cycle' has no member named 'den'
      __entry->den = den;
             ^
   include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/events/clk.h:207:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~

vim +199 include/trace/events/clk.h

   196	
   197		TP_PROTO(struct clk_core *core, struct clk_duty *duty),
   198	
 > 199			    TP_ARGS(core, num, den),
   200	
   201		TP_STRUCT__entry(
   202			__string(        name,           core->name              )
   203			__field( unsigned int,           duty->num               )
   204			__field( unsigned int,           duty->den               )
   205		),
   206	
   207		TP_fast_assign(
   208			__assign_str(name, core->name);
   209			__entry->num = num;
   210			__entry->den = den;
   211		),
   212	
   213		TP_printk("%s %u/%u", __get_str(name), (unsigned int)__entry->num,
   214			  (unsigned int)__entry->den)
   215	);
   216	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--n8g4imXOkfNTN/H1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
DoTzVNhYlFL22eb1M3mT+v+89DOVZtoBAA==

--n8g4imXOkfNTN/H1--
