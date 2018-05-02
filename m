Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeEBMxU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:53:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60182 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751029AbeEBMxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:53:16 -0400
Date: Wed, 2 May 2018 13:52:39 +0100
From: Roman Gushchin <guro@fb.com>
To: Johannes Weiner <hannes@cmpxchg.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <kernel-team@fb.com>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] mm: introduce memory.min
Message-ID: <20180502125234.GA4025@castle.DHCP.thefacebook.com>
References: <20180423123610.27988-1-guro@fb.com>
 <20180502123040.GA16060@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180502123040.GA16060@cmpxchg.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:d672]
X-ClientProxiedBy: HE1PR0701CA0065.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::33) To CO1PR15MB1079.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1079;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;3:5Kn1u5yxtSbdCNlYQB+F030A7FieLu6A4l9lbwwd0mFoFFXyBAOJ3/KY1cH2MAN/TV+KM5kKV5y5Qjyp8YiSxT8McHJavmqkeRW/etlcRBS3G1plBDqqw5MzxG9M5YUgO+B1SmDrRdlGVi9FtwizIAlu4MzTyhnX4rit5rAN5DdYvtYWETwgbiMQ1nUX7Rf8vp4nkHWxJYcRQ90DZrpjL/wXzFR38x1x5UUKPybkU2Sa5cSY8MzfIl9+7dePWZbL;25:RfsiU+Q5Q4+cYRcCwKyhN9+NTEH54yi1iiIocoYr+/urS8ymFKylQ1BCKOAYaOlxtZGbpidoWL/IIhRcDBNmyLOj5pzxQ92aH5656hG8Aupnvz3iyhbEv47wTsEqvSp9LiEQTnAF6EbJcVsf58C1xxLwXjgKqoK/SVjWy90DiRblDVaPtn0sgXQX748gaqtgvKGlYUETkbyZUCZRCgFC4VJTLsS9xeu7HX4iXAliOPVeuLs0YkLSP1Q90Ng+WG4iHCtkFedFZjFlufxSpdUueAEbXNsNs8xX6X8nNJQnXegP7Vqa9sOYO1jbqpPNfNU+YOQEb7SAomDzYAYboqGWDA==;31:a5YrWJu5fUcq+wkaYx5o6VPzSzuQefDVTJaAvlEDaBEDgemPo4hY/M3WRM9At6SwmbIga2JLauXr9Q15USZCWu1IcxAGgoh07Dcz5ew6aIYkpDpHt9KYrv6nz80/ZSfeXH9Kl+O9APfaXiB72OIhwQk7CHTA19EwUJy3KbFqivUhsuVmTaJVfVcANlKVPM82785Za1oKzILU8H/HJsVlFkuCySF+X+1OJ3J5otM6PCM=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1079:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;20:2YRHzuGVnpOf1IY7awiJ5vy9PKh8e14w8fkjmp6zmbydUnYRDEPpdNY+gFwdPjs9YTAWni442ZwfnO0x9zCGLb7gxSEUbxUp3ZrzG7ArhT5+nUkeyFfPw/Xt5JhLEA/Hpm7/1kAur73k7hbFvXKNuuvWz5h6hHEXIC1AsRfQQHHrHYNR3qjb/6kSeAGrsratDa8zOK1qb5jboDX61eUUWVI0wtf1UgxXgSPmPhjU+h027p1JgQ9njWxSC2Hf9CdDl4cbBQms7tDI88zL/nWPIFMnJl2EnHg8r/TVWjI6TAoBeR7xpKMCHpYPjD4KkrhPupzEYxZLO36K7ul9OmTHIm4V16Ystj0BhZfWCrBLnj0B8ypJO2zK5B0tyrk9QzzCY3hn6Bg/6KRpSL95XPuf49rwTK0nyvLIY3kjBA1Lh9XDqBSZiBMftNpv5mdI4ayXrAKEnjWRcn2N0l0FMYT1Lk+fWr6Sml2645rEcVisXasPqleRokGOYgnyE48ZwY0h;4:6r7U8bBuo78HP0KAQmNYmNw4bRdzpSoFhpzNqr80wnwGgrudtwWJRcIO2X1TcIErH/9X2gcBNDZO9gRtDcplgt3r5C3xYu0SQO1OeHba43SGDQHRcHOhLC+vZMWcqQskv0ZD6R6koetvEG09P0jN5cRLJOaV5yyXMGM8aNC+HIKLJUCJWD/0CUlqzQuYBBfJ4nIOgSjnRfGXv5WOWNtlvAMXIdHxei8smMdDdMQ75iV0eH+ScMsSlcyGkT8PZvzTj5ilBrdqXdh35KDcpJaG4Q==
X-Microsoft-Antispam-PRVS: <CO1PR15MB107991E4664C3A23A1900B75BE800@CO1PR15MB1079.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(3002001)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:CO1PR15MB1079;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1079;
X-Forefront-PRVS: 06607E485E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(39860400002)(366004)(396003)(189003)(199004)(55016002)(97736004)(106356001)(50466002)(305945005)(186003)(16526019)(5660300001)(68736007)(4326008)(86362001)(33656002)(105586002)(2906002)(53936002)(23726003)(1076002)(46003)(39060400002)(52396003)(446003)(476003)(6306002)(9686003)(486006)(11346002)(52116002)(47776003)(6246003)(6916009)(81166006)(81156014)(8676002)(229853002)(25786009)(6506007)(6116002)(6666003)(7696005)(478600001)(386003)(966005)(16586007)(76176011)(316002)(54906003)(58126008)(8936002)(7736002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1079;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1079;23:j8eRFbdiN8XC7lbQb2tZxkKCVHOsDL+pHm5UFxo+x?=
 =?us-ascii?Q?2LTGvNDJLk1+iEcFlmAyjSoe/O8wmXaV3DXNI7twFRtMR22cC2wNC7qFIPud?=
 =?us-ascii?Q?m47IeVZXbIZGe6Gu842KJwzgxDDuKj5OHnURK74V5tIz6oNmZHKZJsrM5922?=
 =?us-ascii?Q?57GSP5QKQGvGuC7zCF9oy1pqkvE2eirgmoUd52uDtqUXvURs+OY95HzvsA4K?=
 =?us-ascii?Q?VDrj40sUU0gz/NyI4ilxXzWMsh1/z5R6N57Zgx0Mc0tQxYCxZnMS8yhaywsI?=
 =?us-ascii?Q?Zvr17X0Dyi3I6DCEwmcgEbj1nR8VMCHBajAoUl6UdgVgf/3PdgaGYjKWhRmu?=
 =?us-ascii?Q?VNTSTKwv4skmtGyj2N4SdhnpCEku4ZgkMdySGl98AWCd3Cs9JFVj8UlI/utk?=
 =?us-ascii?Q?52hHW87G2/FifJ26MNt/mAiHPcQDvfAcvDOuZ2E43FbHVP0Y+k111ay8bMTa?=
 =?us-ascii?Q?LhcO4fC+NxYfxbw4XdgLwTxfg3gop+WJuc2hn3xw/epr5pL9d/zIc0YxAUUz?=
 =?us-ascii?Q?fHN4ynBeOWUTIJ7VUO0BTUHnchlU1MN+JW96FdK+bkUq+HuXFv9qctSkz/eD?=
 =?us-ascii?Q?Rg3/qA/D5g/QyqTeIE3E0dpoMnUMS8mCWkQ7PWFjZoYvB1OMAmjSOuP7si6o?=
 =?us-ascii?Q?jWfljke7bl6Q3OS2tSQuX5OsIfAG4VQdR7Dn9FmVZL3oHF0RL7BxH/Vi1BdO?=
 =?us-ascii?Q?EaHoIuFfL04BKLfVfG8HSHST4XPQKX+v1CO3SO2lNWNYu3qFE+z4Z9Mlo7Vr?=
 =?us-ascii?Q?Ot+Gi+dc9of2EY8vRGs15fjU+3iZxJDVnf441Q6U8ZHthU9/fH9fth3RnRuw?=
 =?us-ascii?Q?Be/u6XBpCn/4LxBXiQ2x6bytbJ7WdBRb1LQxWIbya0qfxMfWBgn0bvJ/BA7s?=
 =?us-ascii?Q?fGO73iWRg+cb7m1/Hy5rMEBlCaL/kO1wJnmJa2eU3FJtDhXQqO5c7YEd6oQm?=
 =?us-ascii?Q?3jWM0qtRoSa4WyYKAseefGhENGPbpV7ZMR42UEqp5KWJbBsDErq6grWiN3XB?=
 =?us-ascii?Q?GrHpjxLI8O/yvG97SsQRZGNeV5PG5KVBgXOuwZhHPI9sPi6X8mekBN3ifQAz?=
 =?us-ascii?Q?056C++2kuMGDAhp+iORW1eC0XKqI9YWyLPksp5GFf4t7b3Ob2niex/DC7Wu3?=
 =?us-ascii?Q?Rgtu4U61oNI+3/ImE8Ey4aGaL9JoUuwd7NuaEL0PqTWHtFI20cMqlfu9o/KI?=
 =?us-ascii?Q?44MtkQn+P0Cou8O8s7qkCLh2ZJ49u1K0A0Oz7MHtA5GIakhsZKej6mdAaPhQ?=
 =?us-ascii?Q?agbeXpOlmxH3F2l2hEl9yUVRgUkH1AdONyROFVepcftRGp0/k498ovyAV6d0?=
 =?us-ascii?Q?S8r3YmoiQXDECD3jfUWLVk=3D?=
X-Microsoft-Antispam-Message-Info: lPj/7fR1zOIcqxA4y1L9oAGTVqNhYYE8fr6M5MmmnSuIOc17Y1Dlp6rLlY4mAl3K/cTUy08yITfdN2xpATjGa0TUv13XthMo9lt9Fyipc8+w5lp5QUq2g/xx6JUwZEex+EHo7zVdMc6oSssKxLZy/mJFgIOPPcvcQ45MusjSAaEKmn554PMnGQP8WH7gVmbA
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;6:ZCgjNW9t7wxAQWwdb0tHruxFBkimfU1px1GMtLbXMs6OY568SNnst4sdm/5amo2evotRyE3CqziLhWUusx2qsi5ekN4j4diF5mGa/ZG1B1mTjogKccnFlA5mVf4GlI1b9h5loJsiL43YSe47biNySVPqyfvVi3YfsJGuX751D3L4KLaonafsP9YUAPQZZHMD4C6kp1Htgd/JbYgzIX1Uth+tfr/dTcE3TSF+GgXdPsH9TrvdMWqBy6Eku9bM8du/Cit4ZnizImrrpNeIcSUgrwv6aFnwwCI5OeG2+EOZ49ehmk8tfJ2HYzYxn+7i9qq0UU8519DUzZGErB+GgxJ7FGNK2V7uoqIAiyDFH2aFZPLr7psmMbefowvjHmRS4HBN2EpDkiYjDn63TWjIL9jN5Wp2tDxp8p+T9MEQMQCuCHaJlLcpwqzLTCCdz5DDcnTKtnfK6DTD6Oj5tJC5CEUZUQ==;5:YAqFnQ1CzZW3me47/W2MmygmNoeRLjC20mIOHrd0Y4n2jX4+6m4h4kBAGvcQl3HeK7BgkLlnd+ncAnh4KEp3W4qKtUIJta+Je77b+VawPQwkGzxUbkIBlR8CPVqHPPbNmE6nqXbzHFnmZOMMU/JEWmX4xxdTSYsjUESq19jDbcs=;24:CsEXhh5VPXn2dE86LeUb/8FcCKR+mNcE3MFrPl/+xBLD4YDrd4EeTT7a4U6t6Jpx5ewu0uEsZV2HjBAgbor1MfXbk5DJVBn4wy3PeRD2bMQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;7:vCvRIELtCaS3fzVwT88Fv23R34DRSAh+13C+qK5BlEHmEHW1oWGmEAJ+HHmldsny9jCoDtsXpBz1YgKToB01OZlPEOoQfC0wCRbH2EF76+oLG8tJ9q1jS8elXbQGEE5Enzm3zEMaLbax97/rpDSxlnTylRd23ULCCx7Rs+Ir1XGnNUvPYMa3VngIDKW4Zs03I2wTth7O/UdAO7Cvng9A4P7bjt5q+MuS7kuvshBx+IQ6QhoA0ovey4HxZnX0iF8T;20:ZCO9mdJWaJD3ck+27zynxKEN40LRQc6th4dJpIxhJDLO9PuWzOkPGgFb4VRgq623x15b+7fLWBL4/Bsplz/IRlJrAoiGmSSduK/8msfjiS03ePEVqdKqdRa7A3G1/ZfBBN/UKbC91Ayhh1Dj+3ta5ReiGB2MOar23oqdU4j3Nl4=
X-MS-Office365-Filtering-Correlation-Id: 02d6dd79-7995-4b4a-4c2f-08d5b02ba050
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2018 12:52:53.9054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d6dd79-7995-4b4a-4c2f-08d5b02ba050
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1079
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 08:30:40AM -0400, Johannes Weiner wrote:
> On Mon, Apr 23, 2018 at 01:36:10PM +0100, Roman Gushchin wrote:
> > @@ -59,6 +59,12 @@ enum memcg_memory_event {
> >  	MEMCG_NR_MEMORY_EVENTS,
> >  };
> >  
> > +enum mem_cgroup_protection {
> > +	MEMCG_PROT_NONE,
> > +	MEMCG_PROT_LOW,
> > +	MEMCG_PROT_HIGH,
> 
> Ha, HIGH doesn't make much sense, but I went back and it's indeed what
> I suggested. Must have been a brainfart. This should be
> 
> MEMCG_PROT_NONE,
> MEMCG_PROT_LOW,
> MEMCG_PROT_MIN
> 
> right? To indicate which type of protection is applying.

Hm, I wasn't actually sure if it was a typo or not :)

But I thought that MEMCG_PROT_HIGH means a higher level
of protection than MEMCG_PROT_LOW, which sounds reasonable.

So, I'm fine with either option.

> 
> The rest of the patch looks good:
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 

Thanks!

Can you, also, please, take a look at this one:
https://lkml.org/lkml/2018/4/24/703.

Thank you!
