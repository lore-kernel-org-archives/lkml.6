Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2524989-1525974010-2-5883613579960270095
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii', plain='us-ascii'
X-Attached: .config.gz
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525974009; b=Z1pHSqS49AmhMiouOnxqPGuMXCHZDkr8P7JrmkGd4FHnrANVaT
    4Q8UZWmZCk5RJkzqp93emEjsjkHlwAzPDAzkwUtmearp7NisWk6zUrI1UzGJ+ZsR
    Uq0VS4Ogia9coSg9v5QmpK/qC4f60hrZo+SITr1/Pp+6zBs2yJiKKIkZlmGgBXfz
    OKPBfxsMbvgZjJ+CaZWeZcI0h5z30Dsa5r+aJrh1kU2HTa5YSkZZmdSFquRRbMVX
    6nrfRzVnSk8mumEhLuwv1J72ybcG6oXMDzYm2qcI+InGU7Jp5VjqIwvZdLbID41F
    m6K69kql1ecAb56OJjoq2MoDMKy878uRsV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:sender; s=fm2; t=1525974009; bh=0ZJnygsiSPmGH
    nkok+FLQxq/EABd3wVmRzqpAZMeZQI=; b=U6D6jeVM8Pim0q07cdqB8Y3Fu+X6L
    45vGi5wgAgA3oQNtqibI6w/SR0U32f23YOjvqnMo3IQhBSiyzLGHGJDFJA6KDgj/
    110k3j4mkF0Lx2g+u6VLy4tkDnyXbzdNWMDDvXyBXYB9y5DgvjWaEuhuqgyTA7kS
    MwE1n50jIV0hHMRAOerwo0NGLSi1o3ExA+UlO/Ys89AVNbgQXtNgo1eIRz5kcCRD
    rjDBscNMS9H50STswjfdVzloFoZVj4NnzuaguHrnptf8BkjwmftdRNvF4XPuZH63
    I7U+lAuw7ShZhWHjoloUBqZXS+/MTCltvJG+vW4Hkh6KUVh7q2b0xjxbw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=intel.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=intel.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMPXKpbP+pGr+wu4mpvSI666L5ix7U1Ix/o6Kwz6bw2Q9WwyGDoI0Eyri9AvRMbVoUDyhIWbTFzaagtvF77CVM1PtlX6ooGQWPlSBSK+dAhEntMsbo2M
    3RgTrYB49nUhKnnlxsZb+TxClzpP0d7juyYRaU9/N/1kHB6PI+Tzvq6rG8saHS9UWDFx7b7tnuQMtv5HCVBTiVOpOvDwbnE/jQhzjXfKjewf6ChN5Hz1Mkbi
    f3vJnOq0RgT+7m3Y9xwtnw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=NEAV23lmAAAA:8 a=i3X5FwGiAAAA:8 a=FKr-GBUQJCAXoH5j63AA:9
    a=CjuIK1q_8ugA:10 a=RLNBmAKVMWLTxRvCOdkA:9 a=49ladYHvHUoA:10 a=DDOyTI_5AAAA:8
    a=w27ZC7bHMYj9Vt11HkIA:9 a=pC-h2on8RWMA:10 a=mmqRlSCDY2ywfjPLJ4af:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,386,1520924400";
 d="gz'50?scan'50,208,50";a="227491035"
Date: Fri, 11 May 2018 01:39:07 +0800
From: kbuild test robot <lkp@intel.com>
To: Doug Oucharek <dougso@me.com>
Subject: Re: [PATCH] staging: lustre: o2iblnd: Fix crash in
 kiblnd_handle_early_rxs()
Message-ID: <201805110116.e7LGjXEs%fengguang.wu@intel.com>
References: <1525930679-15227-1-git-send-email-dougso@me.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <1525930679-15227-1-git-send-email-dougso@me.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>, kbuild-all@01.org,
 Andreas Dilger <andreas.dilger@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Doug,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]
[also build test ERROR on v4.17-rc4 next-20180510]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Doug-Oucharek/staging-lustre-o2iblnd-Fix-crash-in-kiblnd_handle_early_rxs/20180511-004953
config: i386-randconfig-x078-201818 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:10:0,
                    from include/linux/list.h:9,
                    from include/linux/module.h:9,
                    from drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h:38,
                    from drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c:38:
   drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c: In function 'kiblnd_handle_early_rxs':
>> drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c:1975:5: error: 'kib_rx_t' undeclared (first use in this function); did you mean 'kib_rx'?
        kib_rx_t, rx_list);
        ^
   include/linux/compiler.h:316:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^~~~~~~~~
   include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:962:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:962:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   include/linux/list.h:366:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
>> drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c:1974:8: note: in expansion of macro 'list_entry'
      rx = list_entry(conn->ibc_early_rxs.next,
           ^~~~~~~~~~
   drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c:1975:5: note: each undeclared identifier is reported only once for each function it appears in
        kib_rx_t, rx_list);
        ^
   include/linux/compiler.h:316:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^~~~~~~~~
   include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:962:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:962:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   include/linux/list.h:366:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
>> drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c:1974:8: note: in expansion of macro 'list_entry'
      rx = list_entry(conn->ibc_early_rxs.next,
           ^~~~~~~~~~
>> include/linux/kernel.h:962:48: error: expected expression before ')' token
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                                                   ^
   include/linux/compiler.h:316:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^~~~~~~~~
   include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:962:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:962:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   include/linux/list.h:366:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
>> drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c:1974:8: note: in expansion of macro 'list_entry'
      rx = list_entry(conn->ibc_early_rxs.next,
           ^~~~~~~~~~
   In file included from include/linux/list.h:9:0,
                    from include/linux/module.h:9,
                    from drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h:38,
                    from drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c:38:
   include/linux/kernel.h:965:10: error: expected expression before ')' token
     ((type *)(__mptr - offsetof(type, member))); })
             ^
   include/linux/list.h:366:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
>> drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c:1974:8: note: in expansion of macro 'list_entry'
      rx = list_entry(conn->ibc_early_rxs.next,
           ^~~~~~~~~~
--
   In file included from include/linux/kernel.h:10:0,
                    from include/linux/list.h:9,
                    from include/linux/module.h:9,
                    from drivers/staging/lustre//lnet/klnds/o2iblnd/o2iblnd.h:38,
                    from drivers/staging/lustre//lnet/klnds/o2iblnd/o2iblnd_cb.c:38:
   drivers/staging/lustre//lnet/klnds/o2iblnd/o2iblnd_cb.c: In function 'kiblnd_handle_early_rxs':
   drivers/staging/lustre//lnet/klnds/o2iblnd/o2iblnd_cb.c:1975:5: error: 'kib_rx_t' undeclared (first use in this function); did you mean 'kib_rx'?
        kib_rx_t, rx_list);
        ^
   include/linux/compiler.h:316:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^~~~~~~~~
   include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:962:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:962:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   include/linux/list.h:366:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
   drivers/staging/lustre//lnet/klnds/o2iblnd/o2iblnd_cb.c:1974:8: note: in expansion of macro 'list_entry'
      rx = list_entry(conn->ibc_early_rxs.next,
           ^~~~~~~~~~
   drivers/staging/lustre//lnet/klnds/o2iblnd/o2iblnd_cb.c:1975:5: note: each undeclared identifier is reported only once for each function it appears in
        kib_rx_t, rx_list);
        ^
   include/linux/compiler.h:316:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^~~~~~~~~
   include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:962:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:962:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   include/linux/list.h:366:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
   drivers/staging/lustre//lnet/klnds/o2iblnd/o2iblnd_cb.c:1974:8: note: in expansion of macro 'list_entry'
      rx = list_entry(conn->ibc_early_rxs.next,
           ^~~~~~~~~~
>> include/linux/kernel.h:962:48: error: expected expression before ')' token
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                                                   ^
   include/linux/compiler.h:316:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^~~~~~~~~
   include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:962:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:962:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   include/linux/list.h:366:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
   drivers/staging/lustre//lnet/klnds/o2iblnd/o2iblnd_cb.c:1974:8: note: in expansion of macro 'list_entry'
      rx = list_entry(conn->ibc_early_rxs.next,
           ^~~~~~~~~~
   In file included from include/linux/list.h:9:0,
                    from include/linux/module.h:9,
                    from drivers/staging/lustre//lnet/klnds/o2iblnd/o2iblnd.h:38,
                    from drivers/staging/lustre//lnet/klnds/o2iblnd/o2iblnd_cb.c:38:
   include/linux/kernel.h:965:10: error: expected expression before ')' token
     ((type *)(__mptr - offsetof(type, member))); })
             ^
   include/linux/list.h:366:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
   drivers/staging/lustre//lnet/klnds/o2iblnd/o2iblnd_cb.c:1974:8: note: in expansion of macro 'list_entry'
      rx = list_entry(conn->ibc_early_rxs.next,
           ^~~~~~~~~~

vim +1975 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c

  1962	
  1963	static void
  1964	kiblnd_handle_early_rxs(struct kib_conn *conn)
  1965	{
  1966		unsigned long flags;
  1967		struct kib_rx *rx;
  1968	
  1969		LASSERT(!in_interrupt());
  1970		LASSERT(conn->ibc_state >= IBLND_CONN_ESTABLISHED);
  1971	
  1972		write_lock_irqsave(&kiblnd_data.kib_global_lock, flags);
  1973		while (!list_empty(&conn->ibc_early_rxs)) {
> 1974			rx = list_entry(conn->ibc_early_rxs.next,
> 1975					kib_rx_t, rx_list);
  1976			list_del(&rx->rx_list);
  1977			write_unlock_irqrestore(&kiblnd_data.kib_global_lock, flags);
  1978	
  1979			kiblnd_handle_rx(rx);
  1980	
  1981			write_lock_irqsave(&kiblnd_data.kib_global_lock, flags);
  1982		}
  1983		write_unlock_irqrestore(&kiblnd_data.kib_global_lock, flags);
  1984	}
  1985	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--9amGYk9869ThD9tj
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICIB99FoAAy5jb25maWcAjFxLc+S2rt7nV3RNNucskvg1jlO3vKAoqptpUVJIqtvtjcrx
9Excx2PP9eMk+fcXIKUWSUGdm0XGAsCHSBD4AFD9/XffL9j72/PXu7eH+7vHx78XX/ZP+5e7
t/2nxeeHx/3/LPJ6UdV2IXJpfwTh8uHp/a+fHs6vLhcXP57+/OPJDy/354v1/uVp/7jgz0+f
H768Q/OH56fvvv+O11Uhl93N1WV3fnb9d/A8PsjKWN1yK+uqywWvc6FHZt3aprVdUWvF7PWH
/ePn87MfcPAPgwTTfAXtCv94/eHu5f6Pn/66uvzp3s3l1U21+7T/7J8P7cqar3PRdKZtmlrb
cUhjGV9bzbiY8pRqxwc3slKs6XSVd5m0plOyur46xmc316eXtACvVcPsP/YTiUXdVULkXa5Y
h6LwFlaMc3U8s3TsUlRLuxp5S1EJLXknDUP+lJG1yylxtRVyubLpcrBdt2Ib0TW8K3I+cvXW
CNXd8NWS5XnHymWtpV2pab+clTLTMHnY1JLtkv5XzHS8aTsNvBuKx/hKdKWsYPPkrSAkClla
obtm2eg6mL2btBG2bboG2DgG04IlKziwhMrgqZDa2I6v2mo9I9ewpaDF/HxkJnTFnOo3tTEy
K9Mpm9Y0ArZ9hr1lle1WLYzSKNjgFcyZknCLy0onactsMoZTc9PVjZUKli2HQwlrKKvlnGQu
QCnc67ESTlJ0tOGod0Y1c01bWPhMmJFdyJtOMF3u4LlTItCJZmkZvDNo7EaU5vp8oMM/3mbU
OuhH6t+6ba2DRc5aWebwSqITN74nEx1nu4ItxpctavhfZ5nBxmC3vl8snRV8XLzu396/jZYM
FsV2otrAO4EJgcWy1+dnh2lp2CR3QCVs1IcP0M1hwo7WWWHs4uF18fT8hj0HtoiVG6ENKAK2
I8gda22dqOsalEeU3fJWNjQnA84ZzSpvw5Mecm5u51rMjF/eXoyMeE6HBQgnFC5AKoDTOsa/
uT3euj7OviAWH3wHa0s4RbWxFVOwcf96en7a/zvYPrMzG9lwsm84mKC/6rdWtILo3esEaHWt
dx2z4FtW4bq0RoC5I9qxFvxtst7uHDkGTAhUowyO2DwVLIDlq5RotRCDrsPBWby+//769+vb
/uuo6we/AOfKnVnCZQDLrOotzRFFIcCv48yLAlyDWU/l0LiBnUF5uhMll9pZSJrNV6HyIyWv
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
NTgr/A/O7TD6seQBAA==

--9amGYk9869ThD9tj
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--9amGYk9869ThD9tj--
