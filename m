Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752921AbeEOVWR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:22:17 -0400
Received: from mail-he1eur01on0055.outbound.protection.outlook.com ([104.47.0.55]:35896
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752881AbeEOVWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:22:09 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <23f37e5a-dd30-0ad3-a5ab-df22bf0ad7f9@mojatatu.com> <vbfo9him0d7.fsf@reg-r-vrt-018-180.mtr.labs.mlnx> <97ccb118-a3dc-6eb0-b127-9c04adf9e2fd@mojatatu.com>
User-agent: mu4e 0.9.16; emacs 25.3.50.2
From: Vlad Buslov <vladbu@mellanox.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, pablo@netfilter.org, kadlec@blackhole.kfki.hu,
        fw@strlen.de, ast@kernel.org, daniel@iogearbox.net,
        edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 00/14] Modify action API for implementing lockless actions
In-reply-to: <97ccb118-a3dc-6eb0-b127-9c04adf9e2fd@mojatatu.com>
Date: Wed, 16 May 2018 00:21:55 +0300
Message-ID: <vbfh8n81uoc.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1P193CA0006.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:bd::16) To VI1PR05MB4704.eurprd05.prod.outlook.com
 (2603:10a6:802:60::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4704;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4704;3:E3Du4T8oI4/ABUjBFL0cS5usIlxtdXGsce2wICzNu+PJcfBAoK8ogRiyqDy2PNjI470LMjr4j4UuF/crsmwoMTOuBPJlwn74MV26JTr4moDq5WwiJcZbbtswRAG/kzQBOZ3BDbm4mfCOxyM6RJSvh4/HVmI87xlA+276XW/WJ6Oe3PbxCvSPOFInI0jxdNdmAGycKgcl3vMC4bQ+rNCjPoLrDyE53NKCOo0QON04cM76X+fdb5ohT6ERvPsS4WVk;25:NC++9f6OV9Y+q+EbBizJRj9cvrXtUrHuUiIoNn0Jyt7hu+MS5xLT3UTkaM/EBSeYdOlaiZ/FZMQYQuRzue2PMCl/KX+S7QF/wuYwkq5LesV6L6RvaQnosfftC1+jITVvCo8F0pW8df9igQ/qd5pV3Knwp9Z8BrdNgRroXCrJvr5M0rxFItsovNZq6ehH1MOEjoNa5Xqu2QAzJspnaWtMaAbuQ+17x7XBWRvJtDrBTfsNSj9yaZIgUfzBaeKutLVHG/GhaY5mtvRT8OjogDHn4fpFpqKgtdxJbzUezcpeIj3+28RUlJvufK1aka2DqELezV/NndqeL6Ine9q2uHg5Kw==;31:2B72Qv/hwmFdnDVVqkhXLAZIcKI6Kfu5Uw0AZoo7Hc2PpYv3mUFHSFz3TQeDyAjOs2ealrfks7SrpGLekPxxJu8g5HiRXekl1Ov0dN+krVugGssH31RfBPKEtp6oGZMi24PTNFcEfxK9eN2hcMmrIoyHywEoVzUO0OhuNX7/PvindbpZ3LjRJtZzSHRskadrLU3htxcxNDDobjp+g9BK/pn5TZjbJHd5u7WhQ3jRr98=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4704:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4704;20:wbIdR9Kc9qPa/g/01W4EfcdzZDtaoJIFs1hqKPahzF98y2CXA+bicL8w9CwxJ8W3hdSxdgeOg3r3Be181CMsUxW5sT6s3V200MsUGNnd+F9MyIYbItyp5Wi4kEMwmFn62hIWhywDfjnmpEQ8QDXOTXL/24GDhSuOhIFytA8uQajO1yAGhA4ufMD3EjwC8ckXppFuNbMA9SEnqAr7loQfC6CVk+Um6ZOivtlsD/Xz0TNDdYkk9I2CHbAhhHgAGmcy9AgVes1RZb7zW5hJtiDxfaPggc267+AHtJ58FLwcxq1hUIM7KAx0LrRIJDmhXplHmxJ8oYT09IlOYh3RqZ8FVD6u1TnqOO8XoUA2WKoZ+7tUsRc71xnVcvkhFoJv/yig+Gm3RSk5ADGxAHBYikofMpeUYPuoLAlaa92YAYzrcEA1C12MBexFyO6IKqRd7J6K42Y8FfBXGRr1wQ8AqV5KPYB1CR8J2wb22iG3wip5rpkWpOarxZ6U9Bx2JpSihLKk;4:GuFashNRl0MZ5RZa+iws/ovSb7eNNS5P+4rSoXGP8q8Sp/glSIGpvHYNB2a1RH1JrsJdN5Cd+VTOLafb9qfVfq9qKQUW7e/hlFHWFe13ST2RxwkyoRzJ+A1Q3Tj4xWcE4JnKB1ZBqKi1LZnBIfxmNWSDjsVL1si+6WsjYdSVtNkDMXpYP6I/NYkceFHL6i4TFeSVhULjSRN8rCYgw0tT5ToWEZ2WWrWIkOqEAR7jNHej3FVNWnNjpRzIquAYYZK0VKmLDn05zYBgxwAW7bRNxg==
X-Microsoft-Antispam-PRVS: <VI1PR05MB470418ED5DB7AA33675DC5D5AD930@VI1PR05MB4704.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR05MB4704;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4704;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(396003)(346002)(366004)(199004)(189003)(47776003)(305945005)(53546011)(386003)(7696005)(51416003)(6486002)(7416002)(52116002)(66066001)(58126008)(229853002)(4326008)(76176011)(53936002)(8936002)(107886003)(8676002)(486006)(81156014)(81166006)(6246003)(446003)(97736004)(6512007)(9686003)(956004)(11346002)(6916009)(39060400002)(476003)(7736002)(6116002)(6666003)(68736007)(105586002)(3846002)(106356001)(93886005)(5660300001)(25786009)(16526019)(478600001)(316002)(2906002)(16586007)(48376002)(966005)(50466002)(26005)(86362001)(6306002)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4704;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4704;23:q1vPiOD0Poj8wGbQk3x7DrSrI19RQVW8Bhm/oCXmF?=
 =?us-ascii?Q?TImARNE4BV/OgtPT9h6mUlHO97HwUVST08PzbJqDNFPQVifA/FqxA7H4jnhX?=
 =?us-ascii?Q?mfKl9PVWFFz5PxXatAHBBFCnoHOADlUW//3jAmllC11E+fJUsdA8mf0tKhug?=
 =?us-ascii?Q?QgPxPMdDKSK+mK0MN3KTv8OM/s04/qXYQdEG95Zzs+9hOaEor+J1VRIu2wgF?=
 =?us-ascii?Q?tnMrhsy70zxiEQfCaBPcyOUquAWAKDuJQ8iDj3kJQavih04OBRPEIWKgGabc?=
 =?us-ascii?Q?0FXu6piQF40ENYMGbu0gQ7kQnQ+SgjKLXFFE8RhsmVJY7fFXV0T9VjeqKS3U?=
 =?us-ascii?Q?DK1V3Oo9wJkDMepduXVbJ9TAp8e0KIIUAyUQScGfTZn77HoPKJOpoW5R24tQ?=
 =?us-ascii?Q?/KoQv5NxqvBq79fh18vW0K+XsoOch9ezhqz4KIS6G6aKLoy00vc+eSXMl6+M?=
 =?us-ascii?Q?1AON4tsRjysck02t+497goPyvZNtuC5S8XAxG8HZSXyA44GfgObyMPbx2P0i?=
 =?us-ascii?Q?3MAbS5cMe8fnNho5s9+QmHAXnyyr78sCLvbddkuUvvrtU9zKi8inK2yGnp1r?=
 =?us-ascii?Q?T7Wjon9Y/foD95TUHro/KrhGU/D4slvGPs9V9A4TfGubgNB6wSlb5XBX/g9w?=
 =?us-ascii?Q?VTkMq30mTlc0rqzUzZwV4hpEeCnb0yA6FQ4ZpFWHtlA5fILedqQTP8Jbg4e0?=
 =?us-ascii?Q?hXCnFBVnn2njLL/ZRzLIoVNPIw2W0ESjzHM/2UFSvo7Sew4j+bycAubQ0H+N?=
 =?us-ascii?Q?Ji7/ODYM4TjKKRt1u16f7MyLGxivORSAQU74PYgvCZE9kj0B6F4ajEMISGoL?=
 =?us-ascii?Q?ccfJD79EXGA54xlXK9lsws3bCfKyyWoyEVvB8bIvzaD0nxyaxprW1KGuyK9u?=
 =?us-ascii?Q?QOPsf9fK6ajfQmkDtnmi8+mPSWpvhLjC4EcfY5kg4/peweegHvwGV8TbQPC9?=
 =?us-ascii?Q?uf8r6SImtwcXdIoriLHX/pa+H0kE6Ff+gAtrzguIB6BYWyAH8T0VkG0aqoR6?=
 =?us-ascii?Q?Ei12YO+4yOivOgbIkHsvIDBwDbvA+qSFlkUt0M2LyM/9E+sHXb810R6gH42O?=
 =?us-ascii?Q?jQLBVJb3tn/OmGjAlt2TiwcvQ6PNZnwG7R+NK/BEbchTknMAd+ivKT97rzw7?=
 =?us-ascii?Q?P+a40Rha7sOSJLekkpKPDk6FYCqg1eSIO2zT6C1Ec0VerOnJ5iGipCnugRqT?=
 =?us-ascii?Q?+J1HQM3biPo84etr+m06WZKWM/+NwQMH2e1D7qFgm4YfVrPaKzsJxE7u5COA?=
 =?us-ascii?Q?CgVNOo5phiAThEoUI9kBnzsneGvcP1IMksq+YcKVTVbdozdY34Drj/VsG582?=
 =?us-ascii?Q?vk1tQxeeJcdspAYCkuWSmlGm+HEJAqUwJZIFM2xQM9oDpE/xVLS5KeFNzvtE?=
 =?us-ascii?Q?jHQRQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: Mo/9pk+Hdj5TBB4RH130senuvl8tD+jJJjbqHZMo9Le3Te2Kdal621lWq0s8gq42co+VUXDE4sFo4HwvuDGndlSvoDKftOYN98L+rNlyNkVtreD02Va1nxY8rcO9enburpfVDQo5G3ZG5R6Op0gS3JhAQaXB18hTUTzJcfsmAuxbg+DTAiXxD0wqpHgPYLGW
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4704;6:hAa0vMJH9eEAj+8xmWa928jo/5W0cr/rSTk19c6v/VEsaZVd3KuxZsmTRzna+kg5MirF8zeC/mobJ6HKwmNmEq6G+1wq5pVlkQOpCSDIBHromfQXfa3g2BkST9etOPIzGpkjLl8Z/vu75O5JciQxUfV9B0/jnAVOpEzK8oqQiQT74tZIbiq++ROQOSH2ViOJspTm5XEEoQrG5Cu6TFrzV7CEx0syKZbK5+65x+FJRYPpdrT4SsIsJ9Jzf0V6k9LECb/oCj0Axj/Hyz+AUyXTGZIVK/tkV49bsV+gvhsHm/1N0C/BcpuvLB3o3YvTYgbmIT/0j2MSs2foeBgoRGmB3pnhCLjHvOIKQa7bcGhO/FmZnjbLEuZDLavlim/P2Brbr7Gr99iTZqF9ta5Jd66lypJLVwAM6UoM/by/NSxCG4PfkIv4ghz1WK5bnKaUxj7rQMq4SQkBTEKfGWEDwWSWzQ==;5:5df4E31Dxm30IPoL5aEiWYeG9zJfZibksYlhcvFnq7TzYGHMu6QWb3kEbFoGpm7Ta+v6Rz3g5qCJvXfQbs+Tk95GHeyxlVW+fToh/oHet0kQRuLiH4reNmtLGz3iMMZG//+TvoYWX6xfdnEO91ubZ6IyM+d5k5dsjWG3Onf6Kc0=;24:HN9gVavx8UypUUqvRiyx88+kWZZCsDNe3/bGFBQfUwlxLOWDeKxUWGNyWeff4HWucldq6WfcBdq36fGPBIafT5BoBS3uGOVwnevv+PX/zGI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4704;7:svUrN9YDGuGpXJBONQFPnHkhh6FSwItBmz1WA+fsRQd9hw6i73FUMgonRNiEgHosvo1JPVbkOOzGGTDGVWBzXuVISu9hriqpK1EjGNCiDSHw1kRlLqU5KxYWjzbZrzMrCZMEJkSD2s4aA9bklW17fcemUNy8djEsjC3HLLZTVyzh2djODAdigwaUj4m4Vgewe7fiP3LpF6/c0ttZO7qdN/4oJ48I9HOE983HmS4wJmHKv2aVOhceikHDc6pTzq+z
X-MS-Office365-Filtering-Correlation-Id: c8cd198f-23cd-4e0b-7127-08d5baa9e76f
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 21:22:01.7560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cd198f-23cd-4e0b-7127-08d5baa9e76f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4704
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 15 May 2018 at 18:25, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> On 14/05/18 04:46 PM, Vlad Buslov wrote:
>> 
>> On Mon 14 May 2018 at 18:03, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>>> On 14/05/18 10:27 AM, Vlad Buslov wrote:
>
>
>> Hello Jamal,
>> 
>> I'm trying to run tdc, but keep getting following error even on clean
>> branch without my patches:
>
> Vlad, not sure if you saw my email:
> Apply Roman's patch and try again
>
> https://marc.info/?l=linux-netdev&m=152639369112020&w=2
>
> cheers,
> jamal

With patch applied I get following error:

Test 7d50: Add skbmod action to set destination mac
exit: 255 0
dst MAC address <11:22:33:44:55:66>
RTNETLINK answers: No such file or directory
We have an error talking to the kernel


-----> teardown stage *** Could not execute: "$TC actions flush action skbmod"

-----> teardown stage *** Error message: "RTNETLINK answers: Invalid argument
We have an error flushing
"

-----> teardown stage *** Aborting test run.


<_io.BufferedReader name=3> *** stdout ***


<_io.BufferedReader name=5> *** stderr ***
"-----> teardown stage" did not complete successfully
Exception <class '__main__.PluginMgrTestFail'> ('teardown', 'dst MAC address <11:22:33:44:55:66>\nRTNETLINK answers: No such file or directory\nWe have an error talking to the kernel\n', '"-----> teardown stage" did not complete successful
ly') (caught in test_runner, running test 87 7d50 Add skbmod action to set destination mac stage teardown)
---------------
traceback
  File "./tdc.py", line 293, in test_runner
    tap += run_one_test(pm, args, index, tidx)
  File "./tdc.py", line 229, in run_one_test
    prepare_env(args, pm, 'teardown', '-----> teardown stage', tidx['teardown'], procout)
  File "./tdc.py", line 177, in prepare_env
    '"{}" did not complete successfully'.format(prefix))
---------------
accumulated output for this test:
dst MAC address <11:22:33:44:55:66>
RTNETLINK answers: No such file or directory
We have an error talking to the kernel

---------------


Regards,
Vlad
